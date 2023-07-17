Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29318C001DC
	for <rcu@archiver.kernel.org>; Mon, 17 Jul 2023 18:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjGQSYT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Jul 2023 14:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjGQSYF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Jul 2023 14:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891BDB3;
        Mon, 17 Jul 2023 11:23:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFE5B611F2;
        Mon, 17 Jul 2023 18:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4922C433B7;
        Mon, 17 Jul 2023 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618220;
        bh=tDeCMM5zjTKVX7u5C+CozNN3h4clMV+jixsRY29GtBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UXM2W+XHPBMX/7hmpIdreCogXip2wJNFHez7vZkIutUJcFXy5JYqEIRfgJzNL+fQn
         oAvMhiXRPx2HhKF2Ikv1OZ9/I/oQTrd70vG6I7YG2wDYDAI2ZdsGWTWvJo8zUwYfcJ
         WzfmDJedsyJcVbCma3lunJczwmxMGDiU72gW4HDdf5+PgE6OCG0WtqVsbUjfkxnsQo
         CLopdUfyN349xTojh6QlpgPic2/t3ifsXWWz2ATPorBrU+Decr3S1GYqO2UuDDJV2+
         JFudfHYRfoXscCjBllMjW96s/3/EiZFhQYf/4zplTNmKwlopvYGv12JnceUdA0cZRr
         HC+rTJwF5vKFA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 32002CE097F; Mon, 17 Jul 2023 11:23:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu 09/18] rcutorture: Remove obsolete parameter check from mkinitrd.sh
Date:   Mon, 17 Jul 2023 11:23:28 -0700
Message-Id: <20230717182337.1098991-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
References: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The mkinitrd.sh script no longer takes an argument, so this commit
therefore removes the code that checks for the parameter being present.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
index 71f0dfbb2a6d..3af3a86a0091 100755
--- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
+++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
@@ -10,7 +10,6 @@
 D=tools/testing/selftests/rcutorture
 
 # Prerequisite checks
-[ -z "$D" ] && echo >&2 "No argument supplied" && exit 1
 if [ ! -d "$D" ]; then
     echo >&2 "$D does not exist: Malformed kernel source tree?"
     exit 1
-- 
2.40.1

