Return-Path: <SRS0=/SR9=3F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67347C47409
	for <rcu@archiver.kernel.org>; Thu, 16 Jan 2020 16:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CAF20663
	for <rcu@archiver.kernel.org>; Thu, 16 Jan 2020 16:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193366;
	bh=FViLLkKvmlS+IjSrPffURafpqhue4rFgmdhlsmYvXHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PC7172FnAMYSYNphKiQgilINCtkQmK203o9Y0BUGPxMHIaS3rrYVAEbcVZJWf5778
	 nHNbiKZKXOIfGys/w+1lMYgqMzA/m3Bkb6Spfjb/nvb3e9t2bvQIp/8z7LPDbBC1Xm
	 3yMkM323UP6vezmPnCh6M/i5APIf2p+UWRaFjDZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbgAPQtV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:49:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730028AbgAPQtU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Jan 2020 11:49:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D77DC20663;
        Thu, 16 Jan 2020 16:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193360;
        bh=FViLLkKvmlS+IjSrPffURafpqhue4rFgmdhlsmYvXHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qruu+W7Yn5b1O7zUAb8k4QL802p0aCZ4PmCb0yrbSrGBCqYi12cxGD9QRr/IwyVRl
         E6zOEh4YwOlGGvJNTUbK+27MGzn+ruFKJRyuJ0C4aXJ5Ep6QlSxBrniCXTxeLylYgl
         HGCDWk3sHFMXmtF5lMjzyBNG2MrWTBLGVcojg/Ns=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>, rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 082/205] rcu: Fix uninitialized variable in nocb_gp_wait()
Date:   Thu, 16 Jan 2020 11:40:57 -0500
Message-Id: <20200116164300.6705-82-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit b8889c9c89a2655a231dfed93cc9bdca0930ea67 ]

We never set this to false.  This probably doesn't affect most people's
runtime because GCC will automatically initialize it to false at certain
common optimization levels.  But that behavior is related to a bug in
GCC and obviously should not be relied on.

Fixes: 5d6742b37727 ("rcu/nocb: Use rcu_segcblist for no-CBs CPUs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2defc7fe74c3..fa08d55f7040 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1946,7 +1946,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	int __maybe_unused cpu = my_rdp->cpu;
 	unsigned long cur_gp_seq;
 	unsigned long flags;
-	bool gotcbs;
+	bool gotcbs = false;
 	unsigned long j = jiffies;
 	bool needwait_gp = false; // This prevents actual uninitialized use.
 	bool needwake;
-- 
2.20.1

