Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E256C43217
	for <rcu@archiver.kernel.org>; Tue, 19 Apr 2022 00:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239507AbiDSASP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 18 Apr 2022 20:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239537AbiDSASL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 18 Apr 2022 20:18:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D8C140B6;
        Mon, 18 Apr 2022 17:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C0FF61343;
        Tue, 19 Apr 2022 00:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C6AC385C6;
        Tue, 19 Apr 2022 00:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327327;
        bh=9NlmxrB9T+ABKIdX0U+KS7n5FXgtpD+pGztatB46rvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qGfyE9gpRdknQD7hs3lmJRCHCGy81L5xamIRc1dQSanTvI4NdEG/VL0XtiPqwones
         c6kVK/rrcY8ge9jxSanxUgIuXdm9M3M1l8ES4Odmb4BsKneIYhxk+YrYtjdws+kLL/
         /VBpEpqr3OS2Otc5sp3XkNrn7xrXGN/HrLEI31eC0vafytMLdxCVLeelavpuL3AbLH
         gheitZpCpUmJq9hJNkixlowesCy5YTuM3nfif0VrlsJYEbsjSlX/CN1UAtGrPBATVa
         HdfRE3o6/JevYJxUrB8L2VKcb1Y852fh/1nYiyL7QtDg5TIJbpKgVK01YTJoeNhSKw
         TnvXw3QZHEwgw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CCD945C0B86; Mon, 18 Apr 2022 17:15:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 06/12] torture: Enable CSD-lock stall reports for scftorture
Date:   Mon, 18 Apr 2022 17:15:19 -0700
Message-Id: <20220419001525.3950505-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419001519.GA3950405@paulmck-ThinkPad-P17-Gen-1>
References: <20220419001519.GA3950405@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit passes the csdlock_debug=1 kernel parameter in order to
enable CSD-lock stall reports for torture.sh scftorure runs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index bfe09e2829c8..e84db823a50d 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -350,7 +350,7 @@ fi
 
 if test "$do_scftorture" = "yes"
 then
-	torture_bootargs="scftorture.nthreads=$HALF_ALLOTED_CPUS torture.disable_onoff_at_boot"
+	torture_bootargs="scftorture.nthreads=$HALF_ALLOTED_CPUS torture.disable_onoff_at_boot csdlock_debug=1"
 	torture_set "scftorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration "$duration_scftorture" --configs "$configs_scftorture" --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --memory 1G --trust-make
 fi
 
-- 
2.31.1.189.g2e36527f23

