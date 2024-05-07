Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE5215E7F1;
	Tue,  7 May 2024 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074557; cv=none; b=sJt1t994C94SXxgmGS/VITWnNtEwshaCiyLS9WmaSskc9OJ+Eb2IN5sV9wldY5CK/aesmcmBp8SnA6rK+mdWv/v5tuvazeICd/jE3gJUAxjNqklCNCvpua4t6weoqL3b/OvCWCwDeem3WDZvF0OojfT0KrD/6Mh2bJB2ud7ODV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074557; c=relaxed/simple;
	bh=EOftjnAZd5uf9q9CC9tawmar6GdKcCD7no4cBP4OAig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GEj/wOB1rFcDZ1oqMd6Y3lKvCa3P5YG34fH0UUoS44ih9+THIiJ9J7CUGYdLGy5QxzEMnzaRIPKdswuR7SAHRadwxL6d8NUveLRAxqhWWXK3OGjKADUz4oRuV1HvRVHLB5AOp50FzsJWUlJwnetx/A9ebTKwr81OBKd4GjbsOhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivoADhJA; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivoADhJA"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e1fa2ff499so43173921fa.0;
        Tue, 07 May 2024 02:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074554; x=1715679354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrZOUbT7E5D7zH88y+EQ1yyWhied5edZTEw8B++TWpw=;
        b=ivoADhJAQYkMTBI44dD18gwueUHJBmXbpooAG2ZwLPM0U76IRebeWWosrtoqKOybVF
         131JoLZMvZWPRzMUWdgEBr9dh2JYCuaySidwMWK8V1SpFFAo8WCAzIRmOFcHG1VrlkiO
         M8DgG14dJaFX2hi2v7hzsH61GUV8UQqsZgw2eJRNNfbsGp1xjAh0tIqGT1LUXjZoQMOD
         4GsD+n38b8yggflGUxFhxYlmB+7wYDEKzdN1ol6UrG/tlhI8vCckXrJ8u1t7oo3e/8fM
         Cj1lPo2xMdtv7ae86nzNncxjBaNDrYSxxMPOa/BC9V/zJNYnmAJ0j15TAXXKvDDZ3d6d
         qd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074554; x=1715679354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrZOUbT7E5D7zH88y+EQ1yyWhied5edZTEw8B++TWpw=;
        b=n33f+dDFC/X2HSk06HW5uGbDVsgdyfSNiD/0lJ0ZwZSu4yvkYDsgV8Hk4xZLptMWRd
         ob4jsf2/971Kd01hO+WMGHWCVInjgWR+6y6zR8HDGEl8pEGBUJEeCeoPmNftsd0gNM5p
         rlQ3YjDC1qB/1EsU+sTVXF5nGlCyZYRZ2bt/sfWvsfOCQF6HYHYuFS7Z7fHtVljr1Otu
         fk2Px+N8qw6b5FH41gAWApexyDodKAqtD9PmQTjChWUfJvmcvowpj2xdBvf7WLQ/cusf
         k6LqAIOhEu7exyf22N8iiWhv5VHg4qBIzYR5IZ0HY10qc6UTQ8+q6MwfI4bVB+7ZL9Bq
         6iKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWzsGzwwHNnvq2kKrrQSluyHPOXNehgYTIGy57ooY0mgZnGJ0HbjJqilM8ajZDjacTojjG0xaIONV6KEAn97/uUxS1lXVko6J2Rcen
X-Gm-Message-State: AOJu0YwKq8ZusZ/J0uM9ujB55isA+760gZlJfwaaVgiLpgffCbjoh/pz
	G3ZE4rqFhkJfpdQCpFkUwJgoY0DDWB0KuzP6tnP/zRUnXj7NeBdK
X-Google-Smtp-Source: AGHT+IHFbrIdKIIUDzFISLiWsY7z6rdJ3rfIId7xJWmLEY2K9EoZ3Iq9bHUjbOEGDS6bgMUUAeXUFg==
X-Received: by 2002:a2e:874b:0:b0:2e2:6f90:8b84 with SMTP id 38308e7fff4ca-2e3d9b8bb94mr7233901fa.17.1715074553998;
        Tue, 07 May 2024 02:35:53 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:53 -0700 (PDT)
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
Subject: [PATCH 22/48] rcu: Make Tiny RCU explicitly disable preemption
Date: Tue,  7 May 2024 11:35:04 +0200
Message-Id: <20240507093530.3043-23-urezki@gmail.com>
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

Because Tiny RCU is used only in kernels built with either
CONFIG_PREEMPT_NONE=y or CONFIG_PREEMPT_VOLUNTARY=y, there has not been
any need for TINY RCU to explicitly disable preemption.  However, the
prospect of lazy preemption changes that, and preemption means that
the non-atomic increment in synchronize_rcu() can be preempted, with
the possibility that one of the increments is lost.  This could cause
failures for users of the APIs that poll RCU grace periods.

This commit therefore adds the needed preempt_disable() and
preempt_enable() call to Tiny RCU.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tiny.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 4470af926a34..4402d6f5f857 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -153,7 +153,9 @@ void synchronize_rcu(void)
 			 lock_is_held(&rcu_lock_map) ||
 			 lock_is_held(&rcu_sched_lock_map),
 			 "Illegal synchronize_rcu() in RCU read-side critical section");
+	preempt_disable();
 	WRITE_ONCE(rcu_ctrlblk.gp_seq, rcu_ctrlblk.gp_seq + 2);
+	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu);
 
-- 
2.39.2

