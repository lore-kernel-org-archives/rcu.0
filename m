Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA7E1509AF;
	Tue,  7 May 2024 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074543; cv=none; b=I70WtToGa+dOwnQJbSBDAZuBHj1IV1NTeSTfoeN3apEPGqY0TPAfjrPk6eCidcIBun2WRDih5APdU0z17347h+Sb96LFmWBAU3jLoE4uPAKqpGN9iTWgp32AImnCDBubWBi/Cso+dQUfOd7q+MkICqPI0eGR1PiAguLjyAHlAn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074543; c=relaxed/simple;
	bh=DV6vIFK2FLypyV6BWlos84+4RzQSRmAQjUtGFDgwpX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UqawW25OtcAXZFvWG0QUqZlBiCpsQq4duRrVhbChfCpAtlG+EXhGMZJahjTrG2coseXAiAvwQ62inlhYzyCg+GagPE3Amiz7qyBaMeqKacp5/SbpUADoFYJPIu6XuA+YCZcxqWoWR6KbV6OSG6NRgTPLQrvJ08m6wiaooQ90ixg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecJPLTry; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecJPLTry"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e367c2457bso20445671fa.1;
        Tue, 07 May 2024 02:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074540; x=1715679340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4dwCi2d+dr1+Mr0Ui3A39VvgagQ4Bs0gp3srLfjB8s=;
        b=ecJPLTryxx6Z6pYydxAWPK+GJ8+aIUFyzfptqKvn8J/XjA9cUMaJb+pAlPh7gVVwEs
         0Mcd3IzV5Y1S8tqAg7BnzvCQxqwEULe+HinU1PZCgIov+xS0FJxV7KlJB8K/B44SbMWw
         I1HhJYrhxaq0H2wKvtJYgvovXPnk9Df0HGCx5aCUA8Ebe6fyde3JbO8Md5yXJGZqUTby
         S18qa4cT2HfpCQrJ8hh9yaSf0mquyL726RKjx29xLKf0f1h3un5x3lVuNa+HUxBz6lCm
         3FSSFxzrOEkw6SdnNjzH34soZtzbkOCV72NYM/lFf+atXBvDPCfeUIebEuMPNyiYBnhR
         /I/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074540; x=1715679340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4dwCi2d+dr1+Mr0Ui3A39VvgagQ4Bs0gp3srLfjB8s=;
        b=rcxws+ENHjz0ckvObCqXMgGj61XfxRanWIVvVQ4e+Z9XhlfYDvl0FErDCodgaz7o0V
         0d9LN295fh/0w46ke3eh0PRFmxwl/qvE9WeuI/M4vfYYsBQ1v3inp7kN10YWPS2u0sAy
         uVZRDWVTZ2epP7O/inM0vSFMtoCDglrQG0tQwlK5xYhVifcEbjok1Zm9FZLWvAyTHjp1
         xGRzepXoMZSH1Lukdeyg0J7Y53s+wtViaXNxjlIb+WJyofJJJ1yiFncOPOTuJ7g7dih0
         XOxudgagHlHLjnPcjaTayNXhaQHohOIhQUwbM3bQuTip9fZKnqLMQTxVqNT7LKdkImjA
         wn2g==
X-Forwarded-Encrypted: i=1; AJvYcCX4NYPqdYJtWaxTv6tDzSVcaeUD6Y9UPv97EVcDD3VkSRNo7xFCkh5uc1kHAXXF6p6Z7PINb5s93xNhQMf173qFrN461VtFgrXj/axJ
X-Gm-Message-State: AOJu0YyP8mAhKVsDYPPIcWXoa47VN5+53dNBALuZDSVBLhTHnSQ/eRg4
	S1JWLV1WC77IdhXfLmeNZqR3FdDuUChtosT7qHtvpTEQjzBnl5D0
X-Google-Smtp-Source: AGHT+IFImqgKNBlFQdFXMbNhwPY/Z+4UJzIWcOtBdwmOrjE48c1ZjErp2rw2AfPF6aTfdENuCsEUXQ==
X-Received: by 2002:a2e:a589:0:b0:2df:a177:58e3 with SMTP id m9-20020a2ea589000000b002dfa17758e3mr10215793ljp.13.1715074539565;
        Tue, 07 May 2024 02:35:39 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:39 -0700 (PDT)
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
	Frederic Weisbecker <frederic@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 07/48] rcutorture: ASSERT_EXCLUSIVE_WRITER() for ->rtort_pipe_count updates
Date: Tue,  7 May 2024 11:34:49 +0200
Message-Id: <20240507093530.3043-8-urezki@gmail.com>
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

It turns out that only one CPU at a time will ever invoke
rcu_torture_pipe_update_one() on a given rcu_torture structure.
This commit therefore adds three ASSERT_EXCLUSIVE_WRITER() calls
to enlist KCSAN's aid in checking this.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcutorture.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index eff51a26216f..d8c12eba35b7 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -466,6 +466,7 @@ rcu_torture_pipe_update_one(struct rcu_torture *rp)
 		i = RCU_TORTURE_PIPE_LEN;
 	atomic_inc(&rcu_torture_wcount[i]);
 	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
+	ASSERT_EXCLUSIVE_WRITER(rp->rtort_pipe_count);
 	if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
 		rp->rtort_mbtest = 0;
 		return true;
@@ -1399,6 +1400,7 @@ rcu_torture_writer(void *arg)
 		if (rp == NULL)
 			continue;
 		rp->rtort_pipe_count = 0;
+		ASSERT_EXCLUSIVE_WRITER(rp->rtort_pipe_count);
 		rcu_torture_writer_state = RTWS_DELAY;
 		udelay(torture_random(&rand) & 0x3ff);
 		rcu_torture_writer_state = RTWS_REPLACE;
@@ -1414,6 +1416,7 @@ rcu_torture_writer(void *arg)
 			atomic_inc(&rcu_torture_wcount[i]);
 			WRITE_ONCE(old_rp->rtort_pipe_count,
 				   old_rp->rtort_pipe_count + 1);
+			ASSERT_EXCLUSIVE_WRITER(old_rp->rtort_pipe_count);
 
 			// Make sure readers block polled grace periods.
 			if (cur_ops->get_gp_state && cur_ops->poll_gp_state) {
-- 
2.39.2

