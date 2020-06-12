Return-Path: <SRS0=lJWX=7Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77842C433E0
	for <rcu@archiver.kernel.org>; Fri, 12 Jun 2020 02:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B6A320878
	for <rcu@archiver.kernel.org>; Fri, 12 Jun 2020 02:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgFLCIW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 11 Jun 2020 22:08:22 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:34783 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbgFLCIV (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 11 Jun 2020 22:08:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0U.JqOrF_1591927697;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U.JqOrF_1591927697)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Jun 2020 10:08:18 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, trivial@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 0/4] rcu: trivial adjust for comments
Date:   Fri, 12 Jun 2020 10:07:51 +0800
Message-Id: <20200612020755.50526-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

During code reading, I found there are several mismatch between comments
and code implementation.

Adjust the comment for better understanding.

Wei Yang (4):
  rcu: gp_max is protected by root rcu_node's lock
  rcu: grplo/grphi just records CPU number
  rcu: grpnum just records group number
  rcu: use gp_seq instead of rcu_gp_seq for consistency

 kernel/rcu/tree.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.20.1 (Apple Git-117)

