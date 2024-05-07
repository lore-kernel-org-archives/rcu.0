Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A74E15D5C8;
	Tue,  7 May 2024 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074553; cv=none; b=nBI1laWcuaF7upX2BqiehXgNuZM1KBtbxBo2CrU8jqraDqu0cKQqdw8PcnemxdoEF/7dDbyrbmdZ5BvpBiSA+qXfL3hT7/+i8KVD75MHBiGmJGrC2gge8Hxl5X9ol1T0jUBuEep527GpEWBy5BpwXRykSldiLWhPRTW8Ptc0ggQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074553; c=relaxed/simple;
	bh=2LOVrQyF12vAmEu/o2Pc3Gqxkejx5J3xKLLX1Ni5V0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VO2TbCPXLuMCPwNvGdZ3LnFvrU0rDRArMtMBAYRAm/DYp7BlY5V8HukP3S0V0KLaFEQVFz8TuyUcBxlVgt6+diq7M7SJ5wCX0NTkxZOs8+gu89V0LS9e5L+VFCOlXRc0+SE44v5UzDUBS0FWgUFY3OCOVRJWTOEza1WQmQqJ+rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaFmP+d6; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaFmP+d6"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2df83058d48so35508451fa.1;
        Tue, 07 May 2024 02:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074549; x=1715679349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6u5ux+babHEh3iKjrb16crvTQ8dT+WrG3HJ02SvwUbk=;
        b=QaFmP+d6bR+Mi7zYKq7ptwZYVAcCVPNucagNk5twOzJVXC/dXFce2Rrkz0xhztYceC
         G0YPC67mgRhoJ5zpBkg7qvOUbxNQbNedg5qGD4ThLUFvQWT3hqNi/8gHMZAoHtrGUyGm
         OB6EdZ3518Wu89kdMzInAxRW+97utrVkBR7zPsB7XDd7TjkmuMf6vMeKfgy3fm74YaB2
         TCUVdI2KAZPRSAol60g8PHiN+PDqzEUK9w0onrvuOIa9gVwa24uAQi3nNB0XeJy1FRFF
         qZuY4rCwqtTFpO6tpoD4CVbqH3Be4W8PFFqkU/1N/qskmB9SPRPYMWBFmtrw6vXu0FTR
         j/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074549; x=1715679349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6u5ux+babHEh3iKjrb16crvTQ8dT+WrG3HJ02SvwUbk=;
        b=wMoU94t5cdomj1IL3nJ89QcFNVH6YTddKu5HWzHXhHRD0RnGL7Vc9jznkpUUo+Sw6I
         YbniQCuIl5oLuYP15Kd6tDZn/THoKTqFKxAiLgRHJDMaSuCOoanJxvv18tFtPn8CqZJ+
         Y3BTKImKetIVQnq5gRQJmaHsdqlCoBaq72GIBlCnOHaxxld7+czon7SpDz25yUP+EuSQ
         2dO6TXO+b9YbLoehUusR7gziH7MouERWzy/uqv8hijVjBYtrrNKQu1vKhtD3cR/byl+M
         yMFXe+CD9EJy98udo52aGFdSX/cY5ftPAeL6hjjRbPiRCoQ39okL5WPXQMYbsCvr10jv
         yEeA==
X-Forwarded-Encrypted: i=1; AJvYcCX6xeAy4sPcfgv5W1QZwQwf9v73EwmeRQu1ZzsBexlKAW62F90P76OuoitiQVH9M48Iap8hQlEeF19OHx65VyacOY2R2kUjBOYeDrCx
X-Gm-Message-State: AOJu0Yz9eIiOZufavDMa3s3Ul8JxbAyZtjwTU9TwgiJ634CPiVXD6thY
	tog7mnUbHntqupNbIqz4jURMygIQcWueDLpjx0d5YO8qSZS2twNCIh/G2u/1
X-Google-Smtp-Source: AGHT+IESvo928QYIKVoiGJbS3Gqs7DuqvngqFe4PS3eX9ShGzVXSihMCTUfUgehug3MiuXvwwkmFdA==
X-Received: by 2002:a05:651c:a04:b0:2e1:e553:7b9b with SMTP id k4-20020a05651c0a0400b002e1e5537b9bmr8674655ljq.45.1715074549444;
        Tue, 07 May 2024 02:35:49 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:49 -0700 (PDT)
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
	Ankur Arora <ankur.a.arora@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 17/48] rcu: Update lockdep while in RCU read-side critical section
Date: Tue,  7 May 2024 11:34:59 +0200
Message-Id: <20240507093530.3043-18-urezki@gmail.com>
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

With Ankur's lazy-/auto-preemption patches applied and with a
lazy-preemptible kernel in combination with a non-preemptible RCU,
lockdep sometimes complains about context switches within RCU read-side
critical sections.  This is a false positive due to rcu_read_unlock()
updating lockdep state too late:

	__release(RCU);
	__rcu_read_unlock();
	// Context switch here results in lockdep false positive!!!
	rcu_lock_release(&rcu_lock_map); /* Keep acq info for rls diags. */

Although this complaint could also happen with preemptible RCU
in a preemptible kernel, the odds of that happening aer quite low.
In constrast, with non-preemptible RCU, a long critical section has a
high probability of performing a context switch from the preempt_enable()
in __rcu_read_unlock().

The fix is straightforward, just move the rcu_lock_release()
within rcu_read_unlock() to obtain the reverse order from that of
rcu_read_lock():

	rcu_lock_release(&rcu_lock_map); /* Keep acq info for rls diags. */
	__release(RCU);
	__rcu_read_unlock();

This commit makes this change.

Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rcupdate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 17d7ed5f3ae6..2c54750e36a0 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -809,9 +809,9 @@ static inline void rcu_read_unlock(void)
 {
 	RCU_LOCKDEP_WARN(!rcu_is_watching(),
 			 "rcu_read_unlock() used illegally while idle");
+	rcu_lock_release(&rcu_lock_map); /* Keep acq info for rls diags. */
 	__release(RCU);
 	__rcu_read_unlock();
-	rcu_lock_release(&rcu_lock_map); /* Keep acq info for rls diags. */
 }
 
 /**
-- 
2.39.2

