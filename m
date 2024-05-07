Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA6914F9DE;
	Tue,  7 May 2024 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074541; cv=none; b=Ys4S5Fb19P5h7D7/Dv1kKo6CRbAdcjl8ePkB0DPAQy1Wof/31CAG2vo2C71XRLQFE5iqFeMh7evzdShfo0g4k5mAXDDcSoKGYAMl7q6+RrgTyUYtR65sB1/B2WA0DN85UoqL00Htm6e4Ld7KG/E5ekWbFSJKhpGtxhGNW4wuj/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074541; c=relaxed/simple;
	bh=woWciDuB/Xya4YTrH1Yno35AomIgowF5eaSff2qzqBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gECjGg+MTUc/xRuZZYdBoX+lpNeBJG0Tl1hXRqNmdt7T9HwzU1ZOs7UDygqRv76xx+vNUqzp+EGCY/m+vg0OufPTFv/VkhjTxlFmJ8I3I389fWvOqE2Qm6iINPzAsifEj7Y6PXT6t30Vw2h0tegEBeXiAIqacDLTaRXFnSnkWqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GThhpff7; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GThhpff7"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2dac77cdf43so37615171fa.2;
        Tue, 07 May 2024 02:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074538; x=1715679338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eclAVoj14Efpyk+hWPVGoQ5bvRfQw2I1KgUC6c1EF4Q=;
        b=GThhpff7B8Jfh0Ak17LSSKb55NG4Re8RVvwN13VWb9OER8xD6g5yJiPXolu2cjzhTa
         Vm7IG0kJqudqegw+Hb0zSsSvtrstuTO7mudWid+FvdHAB9Qh4nyFxlogVtEgnfjOHBbC
         0A6SJ6EvaFVtwa9uTI+LUKKrLD58k9qgY1O3vWnJBrtoy+/PMsgkAsJYPPXlx0KwgzzV
         evKwzrj8QlBO2t6eJuz5F3tBuArI49GYolexkFwFsvyJVRVLPrDFOaQbSTLnr0NTcPfs
         GzmjjZutpfRHRJQmkHDjOX2QSaSSdJ4EYMdAY00Coc5i11+14mpAfHE2QoaNmI59NKVg
         BJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074538; x=1715679338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eclAVoj14Efpyk+hWPVGoQ5bvRfQw2I1KgUC6c1EF4Q=;
        b=oN9HDdkzppTF6a/g46as1ws/gVTlO0px8Y+tfVBT2clMpWSthfvhm5OFtSXb+ARNRO
         clyMpZBSzB1VASg+PLaXVlD3e7Cn5803RpyjNTxyN82Qc+C+vITrhoKmvc3sGjVpqFZ8
         oz2owTLyYf3K6pIqfwHHXV8iJ3X1Ts19OD8pGrttKTwYM2Bd5gVa8b06quEIQKMXU7eK
         wNC9y7WA7Dfwe23sPCPvtLUdHHDnQP7uPjrEl8CgCL12atxFIsQ/v05IHMX0x2rAJx6g
         lletAe4V1gg+wqnQ4g/DoWVzdm7Uss/4WcOrIgR8Jgt290LFP+bBnmETm6wqV3rQQgqm
         1Crw==
X-Forwarded-Encrypted: i=1; AJvYcCXhBB3mvll0KMg4mXtl2DIJIvGbCzBN7dqh/jsF+huTWXvd27x1W5Z+pi24aJJYu3p7O+Z19TLoKj8RcMNKs6Higa/mplt7J+WzSTw+
X-Gm-Message-State: AOJu0YxBo+nDnJLsftlXQ2A31Sj3HxBp0U/b/0NOLYqSMC2Scehqlgbl
	qVccRn28BfwlNzrDyVCReZPk50DcT4L35ySP2Ot97XLws4Hhf6VrttvAMA==
X-Google-Smtp-Source: AGHT+IGbYyKSNB5D70RlkZLzMwWIHSfHqLyIlG+C0IZsnXgPjVQk3IEXoTTrtyWHDjbtXjQYK5zuqw==
X-Received: by 2002:a2e:80d3:0:b0:2e0:c689:f8cd with SMTP id r19-20020a2e80d3000000b002e0c689f8cdmr8709643ljg.29.1715074537908;
        Tue, 07 May 2024 02:35:37 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:37 -0700 (PDT)
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
Subject: [PATCH 05/48] rcutorture: Dump # online CPUs on insufficient cb-flood laundering
Date: Tue,  7 May 2024 11:34:47 +0200
Message-Id: <20240507093530.3043-6-urezki@gmail.com>
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

This commit adds the number of online CPUs to the state dump following
an unsuccesful callback-flood test.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 45d6b4c3d199..6611ef3e71c3 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2833,12 +2833,12 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 	if (!torture_must_stop() && !READ_ONCE(rcu_fwd_emergency_stop) &&
 	    !shutdown_time_arrived()) {
 		WARN_ON(n_max_gps < MIN_FWD_CBS_LAUNDERED);
-		pr_alert("%s Duration %lu barrier: %lu pending %ld n_launders: %ld n_launders_sa: %ld n_max_gps: %ld n_max_cbs: %ld cver %ld gps %ld\n",
+		pr_alert("%s Duration %lu barrier: %lu pending %ld n_launders: %ld n_launders_sa: %ld n_max_gps: %ld n_max_cbs: %ld cver %ld gps %ld #online %u\n",
 			 __func__,
 			 stoppedat - rfp->rcu_fwd_startat, jiffies - stoppedat,
 			 n_launders + n_max_cbs - n_launders_cb_snap,
 			 n_launders, n_launders_sa,
-			 n_max_gps, n_max_cbs, cver, gps);
+			 n_max_gps, n_max_cbs, cver, gps, num_online_cpus());
 		atomic_long_add(n_max_cbs, &rcu_fwd_max_cbs);
 		mutex_lock(&rcu_fwd_mutex); // Serialize histograms.
 		rcu_torture_fwd_cb_hist(rfp);
-- 
2.39.2

