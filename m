Return-Path: <SRS0=QSVt=6N=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82369C83003
	for <rcu@archiver.kernel.org>; Wed, 29 Apr 2020 13:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ACCF2087E
	for <rcu@archiver.kernel.org>; Wed, 29 Apr 2020 13:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b0S+K5Ux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgD2NXk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:23:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57666 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgD2NXj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Apr 2020 09:23:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03TDJkxV139543;
        Wed, 29 Apr 2020 13:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=acBigxhjzNMmYCYO6Lh7nzcLOEw+72Zb51xwobkhS9w=;
 b=b0S+K5UxitDKXXfa/O8196lY5INTUguaNGiHSpo3gX/huK6mBOVlj2hXyew9qxzMM3X/
 BucH6m/Xdd2X5b/7EELKGtVotRBCEIcGuyAqbarQun3AppvNMvM4r+6u5Xpsgsp/2SRV
 f1tfNMpx9sY9dWVCZQUGs71Hu2LhjQOMuCmPKIfcIC3ZHtRlcx5yUxYkD5LG5utPAfE0
 PRZnomK9uxkoghRHdGx4gzU7FNVrh9hT+j1Jzgp7f3fVqiI337zIW6SV7rolDJwpZCeg
 4bYBjMJbRWhqN95Sv0wwsm904PZ+2hrstdnOL6FblcpWjgViRDjRrA+My7baK6UIXO6x Gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30p01nv77t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 13:22:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03TDM71W171245;
        Wed, 29 Apr 2020 13:22:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30mxrv3guh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 13:22:54 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03TDMihK020962;
        Wed, 29 Apr 2020 13:22:44 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Apr 2020 06:22:44 -0700
Date:   Wed, 29 Apr 2020 16:22:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] rcutorture: Fix error codes in rcu_torture_read_exit_init()
Message-ID: <20200429132235.GA815283@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004290113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 clxscore=1011
 phishscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004290112
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The rcu_torture_read_exit_init() function is supposed to return negative
error codes which get propagated back down the call tree but the current
code returns true on failure.

Fixes: e02882cd57e3 ("rcutorture: Add races with task-exit processing")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 269881e51dc6d..5270674128029 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2434,10 +2434,10 @@ static int rcu_torture_read_exit(void *unused)
 	return 0;
 }
 
-static bool rcu_torture_read_exit_init(void)
+static int rcu_torture_read_exit_init(void)
 {
 	if (read_exit <= 0)
-		return true;
+		return -EINVAL;
 	init_waitqueue_head(&read_exit_wq);
 	read_exit_child_stop = false;
 	read_exit_child_stopped = false;
-- 
2.26.2

