Return-Path: <SRS0=WNJD=R5=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B6DC4360F
	for <rcu@archiver.kernel.org>; Tue, 26 Mar 2019 19:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FE920823
	for <rcu@archiver.kernel.org>; Tue, 26 Mar 2019 19:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ic2pO6Jr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732244AbfCZTYu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:24:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35697 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732196AbfCZTYg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 26 Mar 2019 15:24:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id g8so8738460pgf.2
        for <rcu@vger.kernel.org>; Tue, 26 Mar 2019 12:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VpO+kH5n/TCwOCtL6i6LDDDwCLUmaIA5kDbeBwsenW8=;
        b=ic2pO6JrvwEPAs1CnVuT7xWHP8ABOKGkFUt9H1s0OLBDzjFRw1epxg+DmzlHEGONnX
         IixtodF2vh92KGgKTGRYdCz8Qfg7aK04HlZJQmLZZu6bgaA7wzxGBDOf24vFPGpVK2hJ
         cmIfAFVEayqe/33wv7JRMHW2vxfovfoZ/Y5Ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VpO+kH5n/TCwOCtL6i6LDDDwCLUmaIA5kDbeBwsenW8=;
        b=UKvKCG/U55zlllDxq4oizJOD27ZQMf7qoVTq9Ig0tFWOpyR6oJTw6WEiUkTJGuOQxM
         d+9Cj9/GZuSGhuyV/W3h2dNwfhCjUzgUfBl2DZ4XC2O+px10iM0sT7Hbna8njrTAyayv
         Bcr1/M9kW7q/jNdpUgeXeZx3dJVEsL7OGFcOvPDcYzoFGqLTPpUC2JcjVsxjurZuYG+p
         FhjIDaJ0cy4SG4d1ThSufsJWA5CanBeqcTK5h6WMGdAoV+a6XhiH8Iq6B+lSU+Qdr1+u
         bF/TsHxu+T1lo/2XjXAQuwhV0lrF6S2GyWpauaLc5jIHDYRJA/n2hZm3YtZYYG/He/mc
         2iUQ==
X-Gm-Message-State: APjAAAV+8kNQ+SK9eP4wdw3VMIT9mTveixl4NCyWk4vUbbuxB2YTmnMu
        fpOYxMMmvLLndZ5OmG7kmXCgFg==
X-Google-Smtp-Source: APXvYqxRuFbNRDdKaMGu2pfXId9tLkyI2m9Vc5ldX1d4DDCuVuNBaT6qoRUfJTbviF9W9099+n61Lg==
X-Received: by 2002:a62:e502:: with SMTP id n2mr31731079pff.242.1553628275495;
        Tue, 26 Mar 2019 12:24:35 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l12sm36761889pgn.83.2019.03.26.12.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 12:24:34 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org, byungchul.park@lge.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 3/4] rcutorture: Select from only online CPUs
Date:   Tue, 26 Mar 2019 15:24:10 -0400
Message-Id: <20190326192411.198070-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190326192411.198070-1-joel@joelfernandes.org>
References: <20190326192411.198070-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The rcutorture jitter.sh script selects a random CPU but does not check
if it is offline or online. This leads to taskset errors many times. On
my machine, hyper threading is disabled so half the cores are offline
causing taskset errors a lot of times. Let us fix this by checking from
only the online CPUs on the system.

Cc: rcu@vger.kernel.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/rcutorture/bin/jitter.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
index 3633828375e3..47bd9829dc55 100755
--- a/tools/testing/selftests/rcutorture/bin/jitter.sh
+++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
@@ -47,10 +47,11 @@ do
 		exit 0;
 	fi
 
-	# Set affinity to randomly selected CPU
-	cpus=`ls /sys/devices/system/cpu/*/online |
+	# Set affinity to randomly selected online CPU
+	cpus=`grep 1 /sys/devices/system/cpu/*/online |
 		sed -e 's,/[^/]*$,,' -e 's/^[^0-9]*//' |
 		grep -v '^0*$'`
+
 	cpumask=`awk -v cpus="$cpus" -v me=$me -v n=$n 'BEGIN {
 		srand(n + me + systime());
 		ncpus = split(cpus, ca);
-- 
2.21.0.392.gf8f6787159e-goog

