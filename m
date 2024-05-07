Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794DE14E2F0;
	Tue,  7 May 2024 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074572; cv=none; b=jPDUisMyCUSVhpES+1KxtoAHdZeoFqabMN7ps2P6Lw22O3ddK0M43vkwefPgFVYANkR3qVey7V18NauJykXGn2Mo3tfVNdxY/BdyPmtqjRGdJJAgqyhTMV47k/5F8GbkvtUqfyDzd0W134LABJ9OpZmLsuKpRjrfFYyqxAsG6ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074572; c=relaxed/simple;
	bh=ZonPLdD8zHKArk7jKUAil4WyUpljr0gYV6ie6TPJnnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MfjvyayXMPlpHk0BrPHz2nxAwleBPQnFS0BBzykZQs8BgVBGxhcS1N/J82XNTm+ctyaokJsm79a0RfMuvwFYbNDKDGZydnar26yV84gSQmxyRhf9Ej2d1D+IfSSO5B5uzvCsWuJypDS2P1NRoz3UBLEcQOIw6SnWEhjRej7douE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsC5mSFE; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsC5mSFE"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2dac77cdf43so37620041fa.2;
        Tue, 07 May 2024 02:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074565; x=1715679365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Wzg2EFUCtxRH8etUmXaucx3Z1jVpwcvQQv3pqRMexI=;
        b=XsC5mSFEsLRULTfr8tc4RBdISh+sjnmB25vQ9unNY+9BK7vR3I/ojNqjY+AoI9Pqho
         PnWKZTf4iyAqWvQtwzzPS7363UFzuSFB+85TwhKD+TzfF+RhGx6+rmggNRycNxnvdjv4
         fOdm9QjayDMgT3Wg2aSDjQbW34D+eOKgSUJgjGf2XsgIFr7rFY9MELljGqPZNHx1PYX9
         r+O/VqhytIFxCLt3p+Z1qgfCHWHRdWo8HrgDi90zaec2sRSKSRolIA4cxQvAcefRNu+b
         rYv0JQiNMcpKKfLSf3kZkD70itLtiVuxpK/70rsiBnPA98e2Dj7RXgZgo0NvF/aC0Gm0
         Dbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074565; x=1715679365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Wzg2EFUCtxRH8etUmXaucx3Z1jVpwcvQQv3pqRMexI=;
        b=otFYN+LQ1+nYS+WIvvsvJK/sSeWAk3T0fQ0XZzYRQMGy5sD9dFjyW1qEsm+un0va6z
         toLdDopYwhKt94jqE2g/wUJgvj+1I8LihVvyT1B8pT8X3OvXDchYEP0VWFSlSfPz4V+R
         1oXanZ1bA5qxJ7SsMaNeVfsoeqD77inDkwGHN3cK5AMhdDAk4FpISjVtEqkHN46merE7
         mRZTBLlcYqj59TlVRAFiHtslcCwPrkQStIv3ww2wKmDl5Wi7fWUnCx0gEy5pKqIkzJY1
         5IbE7S+tRWQv4b4QA9OgCpDDLC6UyaXgASOBAVsqo03BqBA8r/bF/yckGnnYxpOSeFPR
         qOXA==
X-Forwarded-Encrypted: i=1; AJvYcCUFKWSsYmI15iNAvxr4XKile+jlW2MMHgZs+E4V9LXhPIKTvK/Dl7rVzIcYewStfM9HtZGvgMMKYWj90H1RoMQb5tV/UW6VdItw8z29
X-Gm-Message-State: AOJu0Yxhjra6H70GJoQK0zhbqOZKi+R7Ft5Zu7Wnx8gDTHKlYCtsMbBe
	VNabjkgGqyV6wu5nWSd1SI5JzPD0TWk/d9xfQ8xxQKONk9oWFvjr
X-Google-Smtp-Source: AGHT+IFPcRIkObmSrDDYGtNVtOSeyoXB9l1lQvDPOWGnZFWV9+vj3HB5FDw55OWXNeurNzTdURHy8A==
X-Received: by 2002:a2e:80d3:0:b0:2e0:c689:f8cd with SMTP id r19-20020a2e80d3000000b002e0c689f8cdmr8710468ljg.29.1715074564625;
        Tue, 07 May 2024 02:36:04 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:36:04 -0700 (PDT)
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
	Nikita Kiryushin <kiryushin@ancud.ru>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 32/48] rcu-tasks: Fix show_rcu_tasks_trace_gp_kthread buffer overflow
Date: Tue,  7 May 2024 11:35:14 +0200
Message-Id: <20240507093530.3043-33-urezki@gmail.com>
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

From: Nikita Kiryushin <kiryushin@ancud.ru>

There is a possibility of buffer overflow in
show_rcu_tasks_trace_gp_kthread() if counters, passed
to sprintf() are huge. Counter numbers, needed for this
are unrealistically high, but buffer overflow is still
possible.

Use snprintf() with buffer size instead of sprintf().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: edf3775f0ad6 ("rcu-tasks: Add count for idle tasks on offline CPUs")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d5319bbe8c98..08a92bffeb84 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1997,7 +1997,7 @@ void show_rcu_tasks_trace_gp_kthread(void)
 {
 	char buf[64];
 
-	sprintf(buf, "N%lu h:%lu/%lu/%lu",
+	snprintf(buf, sizeof(buf), "N%lu h:%lu/%lu/%lu",
 		data_race(n_trc_holdouts),
 		data_race(n_heavy_reader_ofl_updates),
 		data_race(n_heavy_reader_updates),
-- 
2.39.2

