Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956D1C5479D
	for <rcu@archiver.kernel.org>; Mon,  9 Jan 2023 22:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjAIWSa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 9 Jan 2023 17:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjAIWSL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 9 Jan 2023 17:18:11 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B105111C31
        for <rcu@vger.kernel.org>; Mon,  9 Jan 2023 14:18:09 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id o17so7303373qvn.4
        for <rcu@vger.kernel.org>; Mon, 09 Jan 2023 14:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M+X+ZpbKYqD2Bos6A74tdZyKlmEuf7l47skk4YvY1R0=;
        b=cd3hJikejBsBNDdxpGnP93DV+EufsdnbLwGAcRlytkxxPRwMvucIgCBkjyyzooCf3S
         biNH4AHrae9DZNmGJhDS7lvsducmtTGkSXyB5JNR9Cie4dDPvWM5TIX6pnvDI1AQSirN
         Qw+mUjwm+RBb/RZf/HAjAxpf286M05kBWcGnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+X+ZpbKYqD2Bos6A74tdZyKlmEuf7l47skk4YvY1R0=;
        b=TJpf8fA71e7ta+lPwqZlH8vAgOSg/1DT8gp5kvjGdximiBJ7WakxYWXm2JK3QlSBsA
         D9RtQb3GRGz+myXEpaWdegBuYBsdM6uP6TwKXknHmLlZxNC2OkXswtq8QxGLTLEDLVVX
         hWx7CwKafYUANxjxhda2hlBK6tj2m3pecipmkZAp3/UgJYCRJn9nRH23SEQ2f0AZFBUa
         A+J3gOmD6kPW9fipK4/x3rRJpuegjb37qJL/uKFiSYjkspOKzOWtKi+Tx4GJpw7KXCQY
         FCY0NT4iJlPkRjXDeGhAO7Xa5J8ik8Y7/51V0jswowS/Rlk6MEj/VhWuYy23S1DdvbWw
         C/Ug==
X-Gm-Message-State: AFqh2kqMeHiZac0u1b1z5eqIPj9wuAxSHC6ujt9jIQMP6ustFLiaA9/m
        4iN6uCi8hVNK4Tgo6lOKm64aG+VLtyD4Tsdv9N4=
X-Google-Smtp-Source: AMrXdXu3odBOBhq17KXDLrZPXNfoiSNN2VPPiQYzBMli93B0LlTTd+cw93XNKhFs4MSKzrX1AaCIyA==
X-Received: by 2002:a0c:b304:0:b0:4b8:4089:e21e with SMTP id s4-20020a0cb304000000b004b84089e21emr91664146qve.47.1673302688806;
        Mon, 09 Jan 2023 14:18:08 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id 19-20020a05620a071300b006f474e6a715sm5922171qkc.131.2023.01.09.14.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 14:18:06 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, foo@bar.com
Subject: [PATCH -rcu] rcu: Disable lazy if call_rcu() called when GPs expedited
Date:   Mon,  9 Jan 2023 22:17:56 +0000
Message-Id: <20230109221756.1361168-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

During suspend, we see failures to suspend 1 in 300-500 suspends.
Looking closer, it appears that we are queuing lazy callbacks even
though rcu_gp_is_expedited(). These delays appear to not be very welcome
by the suspend/resume code as evidenced by these occasional suspend
failures.

This commit therefore checks if rcu_gp_is_expedited() and ignores the
lazy hint if so.

Ignoring the lazy hint if rcu_gp_is_expedited() makes the 3000
suspend/resume cycles pass reliably on a 12th gen 12-core Intel CPU.

Fixes: 3cb278e73be5 ("rcu: Make call_rcu() lazy to save power")
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
Paul, could we take this for 6.2 -rc cycle? Thanks.

 kernel/rcu/tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 63545d79da51..93eb03f8ed99 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2594,12 +2594,12 @@ static void check_cb_ovld(struct rcu_data *rdp)
 }
 
 static void
-__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
+__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 {
 	static atomic_t doublefrees;
 	unsigned long flags;
 	struct rcu_data *rdp;
-	bool was_alldone;
+	bool was_alldone, lazy;
 
 	/* Misaligned rcu_head! */
 	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
@@ -2622,6 +2622,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
 	kasan_record_aux_stack_noalloc(head);
 	local_irq_save(flags);
 	rdp = this_cpu_ptr(&rcu_data);
+	lazy = lazy_in && !rcu_gp_is_expedited();
 
 	/* Add the callback to our list. */
 	if (unlikely(!rcu_segcblist_is_enabled(&rdp->cblist))) {
-- 
2.39.0.314.g84b9a713c41-goog
