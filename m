Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1DE15EFB2;
	Tue,  7 May 2024 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074563; cv=none; b=a1LPRkd2nAN4EOte66FM0kPnY0j/kXZP89GR+XXzaF2qqWvcQrdj2cm7cM/iyRYABUYVyv4+T0F8lZv2PDlukqM8Uf7DTcAajnAvO40BQ5hDr5Emtwh3hTZJ2c+7nRzIqrkc1ncWtuhPc00x2sIRPHOoSq9NdfJQnNd8TP4LPYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074563; c=relaxed/simple;
	bh=iDqzod0vjDc8e7O6tpb8LaBVtP1pQYzDsaE2j9NUzOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bSjoZjjp4i+nt2UhTiPlVwdxWvlLBVWNJY5T4e5vZgMhlEvvoox7Nn3GL1iR7bs1DVxlU3aEx3mK+nUFdTKxWMkNIFKKJ5ElZYzG7+t/ASo/wr96yjWTqJ6FLdwUKbSd3kTMqePHHXOWGhEgIH0FBoOXSoiD0IVh84MEHUel74k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzOLN8DI; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzOLN8DI"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e0a0cc5e83so29089591fa.1;
        Tue, 07 May 2024 02:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074559; x=1715679359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meUQG6It7c61OX5rw+9ctPkRI+dN99MXSc+fu3Gh8lA=;
        b=DzOLN8DImWwbVEVYYUUilnSRVyt+e2OQV/Kz5dhSdsvmO4NHJcMFb6YKJnMYPOuOl7
         xXaSj/LIHeqBExtRN283haciyPzqy2JRYo9Fppv3V88bxhaxeTSFaxw0PnyO5azPX89w
         8ZAGGqvU+xoy03whP2kHpDBgPaFN6M9xFgN3NLlOKr+oJYxcPs/BSAJ4DKX7qk2acJD7
         O8kGHPChGRhUd/ykBYzaB/d/9dJYOAcjTizGkKOO6yxxBQBC1lOd/+uBav8NIYdJWZje
         mhzViClqF9o4kvkmwIxkhYCcAHBlNCLdbk6JdWeEwEm+1I7msPVNpEd4Z/0GLCTgFzTK
         woeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074559; x=1715679359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meUQG6It7c61OX5rw+9ctPkRI+dN99MXSc+fu3Gh8lA=;
        b=iBYH7TlQ6Iaz8s/Vtn9MmF8gKV8CZIuzVjwH6zPSKbYJBX7hXVJF3w68DObXECofrf
         q1MRfmcv07nOtVqjiUcpII8PaPuDT5vAgxiAxN1p//EJIXU9k87FD9HAU7ok6tdGe6gd
         mJggTPskgec2dHv5AxC5YJ1mYzEAlYYmF/87vA3rumU42v49TjAcSJPCfyCu/fWorTc7
         IJmsZdudBP3y8YtafaomEreISZSgo0LZ5VNi+xT0ogZvvDPhY1h0xAAIh9DSohLcIheq
         IL96CFdV3FPpTuUFZbtJZUgexpQZsbJ3x2DbwpUI/M4KW8yjobJ5o8WT4t4AGUVO0GIv
         oetQ==
X-Forwarded-Encrypted: i=1; AJvYcCWksIknfyrmVDaDIqH9yu7dTqQEAlren2oYCPdPy8WN9Lc7adbRQdgFzneC5oUmg478u+s+l6QUXq6Aut0Cl+xXHJ/WSsBkcxYHPqF+
X-Gm-Message-State: AOJu0YzFiNua8BOzuk9vYHycobQm45KtviobIB1xqkd0HvJ5F5oGZoyA
	EjkarVdbIMqoMLpQkIYFikrwcRJQBb7PslTh5UlpLidEg5E/dSSr
X-Google-Smtp-Source: AGHT+IGtWDWZT1q9jjh7d1r3JJDYU35pFBtvbBC29f67kkjeb18Ee/eBuT3cN+DDecPGl6zjxnSY3Q==
X-Received: by 2002:a05:651c:141e:b0:2d8:729f:cf3a with SMTP id u30-20020a05651c141e00b002d8729fcf3amr6498619lje.32.1715074559518;
        Tue, 07 May 2024 02:35:59 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:59 -0700 (PDT)
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
	Marco Elver <elver@google.com>
Subject: [PATCH 28/48] rcu: Inform KCSAN of one-byte cmpxchg() in rcu_trc_cmpxchg_need_qs()
Date: Tue,  7 May 2024 11:35:10 +0200
Message-Id: <20240507093530.3043-29-urezki@gmail.com>
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

Tasks Trace RCU needs a single-byte cmpxchg(), but no such thing exists.
Therefore, rcu_trc_cmpxchg_need_qs() emulates one using field substitution
and a four-byte cmpxchg(), such that the other three bytes are always
atomically updated to their old values.  This works, but results in
false-positive KCSAN failures because as far as KCSAN knows, this
cmpxchg() operation is updating all four bytes.

This commit therefore encloses the cmpxchg() in a data_race() and adds
a single-byte instrument_atomic_read_write(), thus telling KCSAN exactly
what is going on so as to avoid the false positives.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Marco Elver <elver@google.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tasks.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 147b5945d67a..327fbfc999c8 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1457,6 +1457,7 @@ static void rcu_st_need_qs(struct task_struct *t, u8 v)
 /*
  * Do a cmpxchg() on ->trc_reader_special.b.need_qs, allowing for
  * the four-byte operand-size restriction of some platforms.
+ *
  * Returns the old value, which is often ignored.
  */
 u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
@@ -1468,7 +1469,14 @@ u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
 	if (trs_old.b.need_qs != old)
 		return trs_old.b.need_qs;
 	trs_new.b.need_qs = new;
-	ret.s = cmpxchg(&t->trc_reader_special.s, trs_old.s, trs_new.s);
+
+	// Although cmpxchg() appears to KCSAN to update all four bytes,
+	// only the .b.need_qs byte actually changes.
+	instrument_atomic_read_write(&t->trc_reader_special.b.need_qs,
+				     sizeof(t->trc_reader_special.b.need_qs));
+	// Avoid false-positive KCSAN failures.
+	ret.s = data_race(cmpxchg(&t->trc_reader_special.s, trs_old.s, trs_new.s));
+
 	return ret.b.need_qs;
 }
 EXPORT_SYMBOL_GPL(rcu_trc_cmpxchg_need_qs);
-- 
2.39.2

