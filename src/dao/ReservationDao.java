package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import db.DBClose;
import db.DBConnection;
import dto.ReservationDto;



/**
 * [프로젝트]롯데e커머스_자바전문가과정
 * [시스템명]영화예매시스템
 * [팀   명]CUTEam
 * 
 * 예매 내역 생성 조회 삭제
 * -----------------------------------------------------------
 * 수정일자           수정자         수정내용
 * 2022.07.09       장혜원         신규생성
 * 2022.07.09       정은우         가독성좋게 코드 수정, list 불러오기 수정
 * -----------------------------------------------------------
 */

public class ReservationDao {

    private static ReservationDao dao = new ReservationDao();

    public ReservationDao() {
        db.DBConnection.initConnection();
    }

    public static ReservationDao getInstance() {
        return dao;
    }

    /**
     * [예매 리스트] 사용자의 예매 내역 출력 (취소내역포함)
     * 
     * @param id
     * @return List<ReservationDto>
     */
    public List<ReservationDto> getReservations(String id) {

        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        // 70일 이내 정보만 조회 가능
        int daysAgo = 70;
        
        String sql = "select reservation_id, member_id, "
                    + " screen_id, movie_id, screen_at, people_count, cinema, title, runtime, created_at, deleted_at, status "
                + " from reservation "
                + " where member_id = ? "
                    + " and now() > DATE_SUB(created_at, INTERVAL " + daysAgo + " DAY) "
                + " order by screen_at ";
        

        List<ReservationDto> ReservationList = new ArrayList<ReservationDto>();

        ReservationDto reservationDto = null;

        try {
            conn = DBConnection.getConnection();
            psmt = conn.prepareStatement(sql);
            psmt.setString(1, id);

            rs = psmt.executeQuery();

            while (rs.next()) {
                int i = 1;
                reservationDto = new ReservationDto(rs.getLong(i++),
                        rs.getString(i++),
                        rs.getLong(i++),
                        rs.getLong(i++),
                        rs.getTimestamp(i++).toLocalDateTime(),
                        rs.getInt(i++),
                        rs.getString(i++),
                        rs.getString(i++),
                        rs.getInt(i++),
                        rs.getTimestamp(i++).toLocalDateTime(),
                        rs.getTimestamp(i++) == null ? null
                                : rs.getTimestamp(i).toLocalDateTime(),
                        rs.getInt(i++));

                ReservationList.add(reservationDto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBClose.close(conn, psmt, rs);
        }

        return ReservationList;
    }

    /**
     * [예매 리스트] 사용자의 예매 내역 출력 (status별 조회)
     * 
     * @param id 사용자ID
     * @param status 취소여부
     * @return List<ReservationDto>
     */
    public List<ReservationDto> getReservations(String id, int status) {

        Connection conn = null;
        System.out.println("1/4");
        PreparedStatement psmt = null;
        System.out.println("2/4");

        ResultSet rs = null;

        // 70일 이내 정보만 조회 가능
        int daysAgo = 70;
        int delStatus = status;

        String sql =
                "select reservation_id, member_id, screen_id, movie_id, screen_at, people_count, cinema, title, runtime, created_at, deleted_at, status "
                        + " from reservation "
                        + " where member_id = ? "
                            + " and now() > DATE_SUB(created_at, INTERVAL " + daysAgo + " DAY) "
                            + " and status = " + delStatus + " ";

        List<ReservationDto> ReservationList = new ArrayList<ReservationDto>();
        System.out.println(sql);

        ReservationDto reservationDto = null;

        try {
            conn = DBConnection.getConnection();
            psmt = conn.prepareStatement(sql);
            psmt.setString(1, id);

            rs = psmt.executeQuery();

            while (rs.next()) {
                int i = 1;
                reservationDto = new ReservationDto(rs.getLong(i++),
                        rs.getString(i++),
                        rs.getLong(i++),
                        rs.getLong(i++),
                        rs.getTimestamp(i++).toLocalDateTime(),
                        rs.getInt(i++),
                        rs.getString(i++),
                        rs.getString(i++),
                        rs.getInt(i++),
                        rs.getTimestamp(i++).toLocalDateTime(),
                        rs.getTimestamp(i++) == null ? null
                                : rs.getTimestamp(i).toLocalDateTime(),
                        rs.getInt(i++));

                ReservationList.add(reservationDto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBClose.close(conn, psmt, rs);
        }

        return ReservationList;
    }


    /**
     * [예매 상세 조회] 사용자의 예매 상세 내역 출력
     * 
     * @param id
     * @param reservation_id
     * @return
     */
    public ReservationDto getReservation(String id, long reservation_id) {

        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;


        String sql =
                "select reservation_id, member_id, screen_id, movie_id, screen_at, people_count, cinema, title, runtime, created_at, deleted_at, status "
                    + " from reservation "
                    + " where member_id = ? and reservation_id = ? ";

        ReservationDto reservationDto = null;
        try {

            conn = DBConnection.getConnection();
            psmt = conn.prepareStatement(sql);
            psmt.setString(1, id);
            psmt.setLong(2, reservation_id);

            rs = psmt.executeQuery();

            if (rs.next()) {
                int i = 1;
                reservationDto = new ReservationDto(rs.getLong(i++), // reservationId
                        rs.getString(i++), // memberId
                        rs.getLong(i++), // screenId
                        rs.getLong(i++),
                        rs.getTimestamp(i++).toLocalDateTime(),
                        rs.getInt(i++),
                        rs.getString(i++),
                        rs.getString(i++),
                        rs.getInt(i++),
                        rs.getTimestamp(i++).toLocalDateTime(),
                        rs.getTimestamp(i++) == null ? null
                                : rs.getTimestamp(i).toLocalDateTime(),
                        rs.getInt(i++));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBClose.close(conn, psmt, rs);
        }

        return reservationDto;
    }


    /**
     * 예매 내역 생성
     * 
     * @param id
     * @param people_count
     * @param screen_id
     * @return
     */
    public int makeReservation(String id, int people_count, long screen_id) {

        Connection conn = null;
        PreparedStatement psmt = null;

        String sql =
                "insert into reservation ( member_id, screen_id, movie_id, screen_at, people_count, cinema, title, runtime, created_at, deleted_at, status) "
                    + "select '" + id + "' as member_id, a.screen_id, a.movie_id, a.screen_at, "
                        + " people_count as people_count, a.cinema, a.title, a.runtime, "
                        + " now() as created_at, null as deleted_at, 0 as status "
                    + "from (select s.screen_id, s.movie_id, s.screen_at, s.cinema, m.title, m.runtime "
                        + "from screen s, movie m "
                        + "where s.movie_id = m.movie_id and screen_id = " + screen_id + ") a; ";

        int count = 0;
        try {

            conn = DBConnection.getConnection();
            psmt = conn.prepareStatement(sql);

            count = psmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBClose.close(conn, psmt, null);
        }

        return count;
    }
}
