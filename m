Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E45115F41E;
	Tue,  7 May 2024 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074569; cv=none; b=SCH8K2suu2ALdzv4zp2kyeWSjPm/xp5NEe/f0IDePSSI/xGYbnf/XBlGkHWQfhXL2AWBkfa2r9QtgReM/OF7hcaKeJcpj8doCoHjse3sYgSZ7dGG8teTez1bV4URX/C7VgZ53mXGvMrOBMDa5p0wNk6MdQWQQACXgaGrxroWq+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074569; c=relaxed/simple;
	bh=QxVXtzdhs6C8lEQAiNycFXjxv31dqO4CFqRpSFHL3Ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MyBpUM7FjPwyM9oo/B0y+hWhSPxTUZspVBYm2IrzLoV45V5aKaTnaypFB92EAzycAWtf/ppY6VFQLpEjy5jpQVgzi3YeRpSJV7/1X8OIBLfRtgsqeENypZx4pP1O4jTMHLxMUEuwjJccjiN623LB5VcVKcX1E2Dnvnnw36kP5Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLQfvSR5; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLQfvSR5"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e27277d2c1so38191181fa.2;
        Tue, 07 May 2024 02:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074566; x=1715679366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwtB62NUslMMWx9PmLeV+lqXAsyxxRJntMdHp4lNxBE=;
        b=PLQfvSR53rRLk/AMgRA6jJ5nz1r2UbozVhuUpGezHt6KlugbXItxyzF++IUr4Yaoxe
         LkVqggHotQkRIrI9knUoiJKT9pUMDFegfL7/pfrdLKwRm7RSVNlwfH6+9nE8mNJ1TACL
         Rqt0CmOgTTrjyc8BvToP4He0CnAXmlEKJvh77C7mXhoPi7yRAukpHdzAOExjHbxOiGGD
         98dpec/hAFjDz1TAJyv32KRQ0k6fZQgV0HRi3G5slrR1WVmapATgzKa1r/JDdv9sUMwf
         5wkiWprF0bP6UQ4OkfCBpxB+sWQ4u3AN8JQKLbUWibgMd7dcO1gnBSUBHHZOaBe6q5uV
         prJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074566; x=1715679366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwtB62NUslMMWx9PmLeV+lqXAsyxxRJntMdHp4lNxBE=;
        b=c46J7K4icpMFPOx27YTjM6eplLbkUw1BEGuHqB2ReEcaqGAP5y7B9LaPtae2bKoEIf
         J2VAQgK14ZcY3jmFuEt4G1PvAU7VKpPuNyrggjeWRv+hH2aAzv/sYfDKHnRffvtRvZbE
         KLlcPM8ZoxYJpTr3jEjHnpJqHvusbKLRVU+DYxnjz4hy7NO59/0/O28vQy1ugGFNcelD
         +oCYIgMYnzI4+P1ApStXLlbxHD8lQjQmKiQ+Gv+n93rbJeQcXQYE3vaPAkQlWAq2oouN
         Ge0GuWKNnvQa5zEP4iMeKUT+xxN2Fm977ip26rXwrlXWOq+oUpNPrpa7T4NPI/mzqXsf
         pn6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1McmewynCObPI+xN4BmFn3eDvDOFYXjq8JRRPuFLaYp7Bp32Vn7l0pHrtMxC7dUMxoN59xhW+XRSN7HSjyBndXtXqaNEBublynb4F
X-Gm-Message-State: AOJu0Yz4bU2yOq9xF2g+boHBW1g8S1fcqaSXRCfX76Ys0obdHF5Klxc6
	+z8/3hKxQbSuU5ije22/HaW6VPNN5DcMIhYAH8fJ1mRWKs27Vc6A
X-Google-Smtp-Source: AGHT+IGRn2UIUjS+sAlU42bGVlq8/pmc6JRVDE1tE+2uv2h/o/UvpfZbSB4cHbbOePDgvd3DdGjyEg==
X-Received: by 2002:a2e:7007:0:b0:2de:883d:1aef with SMTP id l7-20020a2e7007000000b002de883d1aefmr7742109ljc.46.1715074565773;
        Tue, 07 May 2024 02:36:05 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:36:05 -0700 (PDT)
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
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 33/48] rcu: Mollify sparse with RCU guard
Date: Tue,  7 May 2024 11:35:15 +0200
Message-Id: <20240507093530.3043-34-urezki@gmail.com>
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

From: Johannes Berg <johannes.berg@intel.com>

When using "guard(rcu)();" sparse will complain, because even
though it now understands the cleanup attribute, it doesn't
evaluate the calls from it at function exit, and thus doesn't
count the context correctly.

Given that there's a conditional in the resulting code:

  static inline void class_rcu_destructor(class_rcu_t *_T)
  {
      if (_T->lock) {
          rcu_read_unlock();
      }
  }

it seems that even trying to teach sparse to evalulate the
cleanup attribute function it'd still be difficult to really
make it understand the full context here.

Suppress the sparse warning by just releasing the context in
the acquisition part of the function, after all we know it's
safe with the guard, that's the whole point of it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 382780bb60f4..dfd2399f2cde 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1090,6 +1090,18 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
 extern int rcu_expedited;
 extern int rcu_normal;
 
-DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
+DEFINE_LOCK_GUARD_0(rcu,
+	do {
+		rcu_read_lock();
+		/*
+		 * sparse doesn't call the cleanup function,
+		 * so just release immediately and don't track
+		 * the context. We don't need to anyway, since
+		 * the whole point of the guard is to not need
+		 * the explicit unlock.
+		 */
+		__release(RCU);
+	} while (0),
+	rcu_read_unlock())
 
 #endif /* __LINUX_RCUPDATE_H */
-- 
2.39.2

