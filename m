Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9441FDF92;
	Wed, 13 Nov 2024 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495616; cv=none; b=spfUHK5J07xEioAF8BvggGxwsi8Ln5dUlPPc9rQISHiMtfP9GGQv7ALieTAizJUaA/KXEpBwlIdMeJYi6bswV3Sr8fEABKoMTlLxHD0WId+QbGU1R1fPM3OU1sUi9ZLC+C4n+ZysvlnolREgvEx/NXUzOp18ifFc1XkPCsRAjKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495616; c=relaxed/simple;
	bh=I8cRsHQSN0vAF8niCPwBIcvh0901or4VWvAMWSQvXNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rwgW3vhkJF+nHL3moRVUeQ/wpn60G4tmJz+IfrtvN1mwdaxY1D4mGHXRMe1jEdzczdOOBYCezAwGSMWMUss0Qdnw63zaznFM8sBiEIrMWTOJ7I4RC/UHJ4ltpVPaQ+6s68QZT4RqR7hO989WaLzqVMZWF0VV062DePyo+Bu9iU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBghVAqs; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBghVAqs"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e4b7409fso612606e87.0;
        Wed, 13 Nov 2024 03:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731495613; x=1732100413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Sv1E+zxu28KObA7XsFoCV/meODpEN9w1DvDqrRLJFE=;
        b=BBghVAqslFa18HNp+tv4cEFlQDbXr6yvMNaSLd+CGr78jY5HWAFID/F7Nadegw3AEP
         OSZzEzEeX6MU5HMHQjPWIZvavDipPwW2llPZXEY0aH9BiNibeGohIfK/PMPxlZ44n/7B
         86mJIsMTAQHFAV5l9at5FRgnPZZ3uwjrqJj/DI8WjtO/WzENtYgiL/PjuUZoflPSVRO8
         v0RYUTfZt5Lvrw+nQXjZ41vZT73KCRGjEcFVnYoslrkkXs60lhbVzuc0nd/sx/KwQV15
         UGnSONtv+OkaYvxMcC/QVCQHHqC6QO/0RKv4qZFBIiK79hGyFVcyM04svcWcPDgzJTW5
         eIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731495613; x=1732100413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Sv1E+zxu28KObA7XsFoCV/meODpEN9w1DvDqrRLJFE=;
        b=whGjsvLJUMFbyqTDY9Jyi9KXcQhdbMOJJ2tiEoMr1vh95CvvG/aj4WYcl1A4hWSXfL
         DHqpEE5g2ewCKEm6zODgRYR/7C3pOYOhO4DWZpddTU0NdvKQCknK58zjYgIHYqGpsgWm
         1hRGroxbEmg0GI6/GBzlmstBXgOQ34L2J+T83igKSkr1YT0lW8kxD7YS5t9ebZq5q3E2
         fh9rMOkqEyK/yQABHCG66+RI6dNAR3vNl87tuEpQ5WXqyyOy8FZTmOq/LCwmPwFX4pjx
         1ZRWpIjVZHdU6Xytzeu8Y16qNzzXjz77sKMXdiXiCaVmRXqF80NgGFFrj2ZWq1n7Xi/C
         0vAw==
X-Forwarded-Encrypted: i=1; AJvYcCVMD4U1KjWuGK0p3agew0MBdfu57sswoOdpj8fbzQHaP3pLQo41fuqOns7V9F7m/xLOsQx/6DXVoefMwLY=@vger.kernel.org, AJvYcCXOCsMiZmQsbKN1+6UHQhtzYjadHlX+vRVwaL0XVIm461ZwzAV2yFps71HhPFweOIGERJ+l@vger.kernel.org
X-Gm-Message-State: AOJu0YzLUKLK+JntVTYCrApIS71GQkakzEZnQolibK3gpRizcI/x1Rlw
	XV03dWC6GHMlTqznmUiKWCeR5GqvxMpNAo9K8TH0PSlFvDaoHp/5
X-Google-Smtp-Source: AGHT+IFu1W6eDRNA1sRoQfblfzI0TLuXUjBnhBUR0M52Lqq3nLhcsKteHMqvAMNbl4aR5M/Rld2KoA==
X-Received: by 2002:a05:6512:6cf:b0:53d:a24c:5c7 with SMTP id 2adb3069b0e04-53da24c0710mr340726e87.10.1731495612985;
        Wed, 13 Nov 2024 03:00:12 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a7287sm2137119e87.164.2024.11.13.03.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 03:00:12 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 2/2] rcuscale: Remove redundant WARN_ON_ONCE() splat
Date: Wed, 13 Nov 2024 12:00:09 +0100
Message-Id: <20241113110009.65256-2-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241113110009.65256-1-urezki@gmail.com>
References: <20241113110009.65256-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two places where WARN_ON_ONCE() is called two times
in the error paths. One which is encapsulated into if() condition
and another one, which is unnecessary, is placed in the brackets.

Remove an extra WARN_ON_ONCE() splat which is in brackets.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcuscale.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index d360fa44b234..0f3059b1b80d 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -889,14 +889,12 @@ kfree_scale_init(void)
 
 		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
 			pr_alert("ERROR: call_rcu() CBs are not being lazy as expected!\n");
-			WARN_ON_ONCE(1);
 			firsterr = -1;
 			goto unwind;
 		}
 
 		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start > 3 * HZ)) {
 			pr_alert("ERROR: call_rcu() CBs are being too lazy!\n");
-			WARN_ON_ONCE(1);
 			firsterr = -1;
 			goto unwind;
 		}
-- 
2.39.5

