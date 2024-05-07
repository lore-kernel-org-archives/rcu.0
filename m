Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CF716C696;
	Tue,  7 May 2024 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074581; cv=none; b=Z2AxuGS+IMj51RoU5MlDs7AJ24OiAtTB20VoggumcJhYBv1BQy9qsd0G0y9v2sirTiX8uFAcvMfi0ANZp3jnJKyVHHBDSwkS+nZNwcktNUoULaTMOCu6pZ84p+wMDb1nyVp7U8Y3ifnuq5JxZGCPDodrPR4QD8SWrI9RI4YMzoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074581; c=relaxed/simple;
	bh=rm1RFxxDNWACtis5oePDLvdLL18Pj6+dDkJjOP/K3Pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G94eqItcStxe9eN1LGGZLLC9byh0odh88r4rZuyfjYqES4m2Ju6805jJv3xuW/0AgzBSzxpQsYmKbyrb6bb6nbC++SJpO4gAvQXZLUtfEl9ldI6DX4Jk38tEBrZZfw0prTDnSAYbSoF0Nlba/e0RIIvaPTMLt0evBuxTV4zAjCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXnyLpmG; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXnyLpmG"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e242b1df60so34989361fa.1;
        Tue, 07 May 2024 02:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074578; x=1715679378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJIpU92r3nQAC/o5YT3DHRkgaet/v1o2kkX+oJHCr8c=;
        b=gXnyLpmGuGuLvwzYxnC9ZAgc4TaLCsKcwpLV5+aDbTmJ1W8q7h8tkCwmYKqdkfELDl
         n6B0hCP2HilFyKmjeB0TXc7SNzIRoIkh9bvzDPSxkBlVlBcxRvq2XmRuUQzlN/SlHxFD
         gYknTO+u7UNeTTAGtGIZ3sQCM4qzD294C8R8Lm5SQYHpqdgrMAGuQlGGAnBva2f7rLY+
         A7o1EqZl3MYxYUyE4LYwW8k2V5RovFUZHA2EOjde68m0+MYzP/Rlv7OY39n57U/UXUmb
         W3YrYlVZj/W6ddLfeT+YcL2SK5pANXxIUIxkrfpMCJ32Ei0F4I5ajTic5NE/c4BtkjY5
         dovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074578; x=1715679378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJIpU92r3nQAC/o5YT3DHRkgaet/v1o2kkX+oJHCr8c=;
        b=HnUPUArBtIHMY/TiZD/ujB4s1KuVISp8DpJl5+21zM6dAYmA6af9LJKxUrotmFU80T
         NtrC0p/uqDWpc0KExOX7/7NtIRT87DEdCPfHvfKHKTVw5skJmE9XWbGiXjYYuyZQF79/
         IJ3Um5+FyNRb0rExwCrk4xrrW0ChvoCullre2vNh5hYHNPnbsD7pHemPmbgiGpQ2gn2y
         ZChlTPTGEOQixLkqYbANov7OgXVD1sH6p+OLIZVhCTQSVLms/iWxpEtQcF1dDsoOrNpu
         pIaDNCjiOH5qNlhvZLX9jyOa0DrDgKcZLtiWYsAyhC4rPSrEVO6kqnMjc0xZh1O+k7Er
         qBSA==
X-Forwarded-Encrypted: i=1; AJvYcCXcWM/9LhdrKrBt6rh6kbViNa1f+gekegFPdwVh9ZB5BTRx3hre0fibaMq8O+YyM5Atp+j+JFWCbLbi9QHT48jfm4xn3xhUOj+mB99m
X-Gm-Message-State: AOJu0YzgaWhxbUzUksvrSljZQoZtCjqDU+CdF4FeZrivP7yfipzwTsxm
	WuY3UkmH5VpnJ8eM43Q7Y1rmmdtrpkCdFTnZixgQIPP+K823M01tAFkhuv15
X-Google-Smtp-Source: AGHT+IHEbQsnWb0EuVgdTwT+nhbFYd3OItlWoYXy8CGwEd+dwb48l/BzcwfCqOvHhFdpCH4sGMNoYQ==
X-Received: by 2002:a2e:9214:0:b0:2e0:e7a5:7209 with SMTP id k20-20020a2e9214000000b002e0e7a57209mr9547478ljg.26.1715074578247;
        Tue, 07 May 2024 02:36:18 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:36:17 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 47/48] torture: Scale --do-kvfree test time
Date: Tue,  7 May 2024 11:35:29 +0200
Message-Id: <20240507093530.3043-48-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507093530.3043-1-urezki@gmail.com>
References: <20240507093530.3043-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, the torture.sh --do-kvfree testing is hard-coded to ten
minutes, ignoring the --duration argument.  This commit therefore scales
this test duration the same as for the rcutorture tests.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 13875ee7b050..990d24696fd3 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -559,7 +559,7 @@ do_kcsan="$do_kcsan_save"
 if test "$do_kvfree" = "yes"
 then
 	torture_bootargs="rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot"
-	torture_set "rcuscale-kvfree" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --memory 2G --trust-make
+	torture_set "rcuscale-kvfree" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration $duration_rcutorture --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --memory 2G --trust-make
 fi
 
 if test "$do_clocksourcewd" = "yes"
-- 
2.39.2

