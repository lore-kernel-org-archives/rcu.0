Return-Path: <SRS0=j199=WK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=BIGNUM_EMAILS,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F55AC433FF
	for <rcu@archiver.kernel.org>; Wed, 14 Aug 2019 10:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22630208C2
	for <rcu@archiver.kernel.org>; Wed, 14 Aug 2019 10:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r2fn/vz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfHNKi4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Aug 2019 06:38:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41996 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfHNKi4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Aug 2019 06:38:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EAcNWB124576;
        Wed, 14 Aug 2019 10:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=csofQcwTGnIAVYuvVFNpl9y6+B4CfJX9pKX1mCoCQOI=;
 b=r2fn/vz19s8MwVWe+LodbiQs+pLgNldr7I5obI14dJqL+h0cWGUKiks7FTTeIARsmCDD
 ZpnUOC4YTpFZ8VSJQ6xDOPrf+DZOAEMtrLpzWcS2nTxjzuFSrvsRAH33M51+MuDZJ2r3
 JqL1U0u3K3+ojcwlUE8mYs4L2u766Qg8JIgSe2VFof01h/IzwkMEia/KVgoYTWm7OgxR
 JoYANmj0dScg6Ba9sCwBsRG9YAjYqh+Sr+RdqwkPmDdNhcy6s5FrlHcngHupfe0FyDMJ
 y+20ZUyCenNzev3W4JX/6bPjmjybnG5QS6iKcsSicl6l14tYLqn/tIZfCSH3whkX2h10 pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2u9nvpc2j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 10:38:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EAcRvE102121;
        Wed, 14 Aug 2019 10:38:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2ucgeygps5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 10:38:51 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7EAclYt030151;
        Wed, 14 Aug 2019 10:38:47 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Aug 2019 03:38:47 -0700
Date:   Wed, 14 Aug 2019 13:38:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     paulmck@linux.ibm.com
Cc:     rcu@vger.kernel.org
Subject: [bug report] rcu/nocb: Add bypass callback queueing
Message-ID: <20190814103839.GA12599@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=669
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908140110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=729 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908140110
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello Paul E. McKenney,

The patch 1afc4b18724f: "rcu/nocb: Add bypass callback queueing" from
Jul 2, 2019, leads to the following static checker warning:

	kernel/rcu/tree_plugin.h:1792 rcu_nocb_try_bypass()
	warn: unsigned 'c' is never less than zero.

kernel/rcu/tree_plugin.h
  1761  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
  1762                                  bool *was_alldone, unsigned long flags)
  1763  {
  1764          unsigned long c;
                ^^^^^^^^^^^^^^^
  1765          unsigned long cur_gp_seq;
  1766          unsigned long j = jiffies;
  1767          long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
  1768  
  1769          if (!rcu_segcblist_is_offloaded(&rdp->cblist)) {
  1770                  *was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
  1771                  return false; /* Not offloaded, no bypassing. */
  1772          }
  1773          lockdep_assert_irqs_disabled();
  1774  
  1775          // Don't use ->nocb_bypass during early boot.
  1776          if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING) {
  1777                  rcu_nocb_lock(rdp);
  1778                  WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
  1779                  *was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
  1780                  return false;
  1781          }
  1782  
  1783          // If we have advanced to a new jiffy, reset counts to allow
  1784          // moving back from ->nocb_bypass to ->cblist.
  1785          if (j == rdp->nocb_nobypass_last) {
  1786                  c = rdp->nocb_nobypass_count + 1;
  1787          } else {
  1788                  WRITE_ONCE(rdp->nocb_nobypass_last, j);
  1789                  c = rdp->nocb_nobypass_count - nocb_nobypass_lim_per_jiffy;
  1790                  if (c > nocb_nobypass_lim_per_jiffy)
  1791                          c = nocb_nobypass_lim_per_jiffy;
  1792                  else if (c < 0)
                                 ^^^^^
Impossible!

  1793                          c = 0;
  1794          }

regards,
dan carpenter
