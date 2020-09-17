Return-Path: <SRS0=GKHO=C2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3076DC433E2
	for <rcu@archiver.kernel.org>; Thu, 17 Sep 2020 14:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1EF2206CA
	for <rcu@archiver.kernel.org>; Thu, 17 Sep 2020 14:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgIQOMd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 17 Sep 2020 10:12:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50514 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727280AbgIQOKp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 17 Sep 2020 10:10:45 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2C464D8CA3BB2F2434A0;
        Thu, 17 Sep 2020 21:52:26 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 21:52:15 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>
CC:     <linux-kernel@vger.kernel.org>, <houtao1@huawei.com>,
        <rcu@vger.kernel.org>
Subject: [PATCH 0/2] two tiny fixes for locktorture
Date:   Thu, 17 Sep 2020 21:59:08 +0800
Message-ID: <20200917135910.137389-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.25.0.4.g0ad7144999
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hou Tao (2):
  locktorture: doesn't check nreaders_stress when no readlock support
  locktorture: call percpu_free_rwsem() to do percpu-rwsem cleanup

 kernel/locking/locktorture.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

-- 
2.25.0.4.g0ad7144999

