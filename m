Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0AC204681
	for <rcu@vger.kernel.org>; Tue,  4 Mar 2025 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080370; cv=none; b=YjV0oHHTcgTz9fB7q8/n59R9XG8YixiQvRLqnF1ljYhkePpdrqSHDHRN9C+Lsj/ZP1KahV5xBEsg6icySKqJ8KLDAE4qoSHIIRaukghRISRcmINSEnKpXx6tWinDwvbIYJqMvBu+50zuEcHXJeKzTcDWpxCDTbwWOL5H1ilGyjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080370; c=relaxed/simple;
	bh=X1ktC5ZjhhR5WSX79RqJwEmztNg59gjqNnHaZ1eRNbI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pKRYeEnY7eRmZVdo1B9ddc+KirKjMSgM65VhFE+AHGYsfyFWKLzfa+z9rsRFDmcaL1gag1To8xUoV14FHV7wXy5/h2DJjLOdbOcpbY8W6Za+B4Bk/R7ktZKuEqQVgwUqoJxuO6MzimObyxa2wceUz4CRKWjRBYP3PnmdZ+mn000=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xg6WVpOx; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xg6WVpOx"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5da15447991so6390804a12.3
        for <rcu@vger.kernel.org>; Tue, 04 Mar 2025 01:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741080366; x=1741685166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ljSfvhYh8x6xwHsInA1Gu+wF89bLF/D0O2qs3l3oGhs=;
        b=Xg6WVpOxl4Uw1y9DqvyTg/3197RCryGmiSeYMqKUZTtF6ekER1WDtt4QMiXC1TPcg6
         HnOBzDtLMIUNk+pLQAEWYm23m6PNy2Axi/a9mFpCp7arNL23sz7yugjjTL0VVBPQmfB3
         rLoYFizmAR8YildAdPPxqlIMei1XwrW9W//4YPDHVd6dlGFtPOIPYs0SyfHSDWoVscUQ
         Q3zeOgQlAbM9V4q7fahK+x+vvd7CKuq2ESx/uiBT7Lr3XUn3mpCh3w4zYvjgh8D83Kme
         I+feMdM/bDcLp18cuqHklttRGdhpsf3ipe5zBWljPKEX9UY/59IQ05SWZKiEKS+iGxN/
         jq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080366; x=1741685166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljSfvhYh8x6xwHsInA1Gu+wF89bLF/D0O2qs3l3oGhs=;
        b=ZopDUKgWayLx94uq1ttwPuE+la5dDFz/kplMsW1lfqVGlkWsTpmD/hXqrtOmUm1ZPd
         YepP1HwMQQJqGAv0uHmdJcdjQj9uEGJol/htgOSaTdpIqjDPBukrx0ZS2Ljo/kssvtC1
         gXh9ZH8DXg7Nu5EjArZ+7xd7LHbAzAsFSswo1ABzJeDLD/JWzvw9bKqSHJi2MDRRfpfe
         rgSCAKtKLvaD86S42RpntLx43dKL7qD/cNu9MmdweWtIORthmIMQ+AQMsqCQ4LKEwLJH
         jqIsSAuQiOGfC536z8yu/V6xIrblvZttRfNYvEkAeFvC54tDCHgpYxnKaBvPCvmmGLmE
         +hHg==
X-Forwarded-Encrypted: i=1; AJvYcCUqFcZq8e8Xrrz06FNPDnBc4ccdFB1Hca2IqKdiSFl1t5f2w46QmA3vGZ2YRyQGSSjPnkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVFGDj5goKLDEj8bz2zPV5VLpZP9Fwqp6otESwAUJQYKzRepG0
	dq955A9aVzdrkrGKFsstXFGwgsBW9sVF3KUThxCDZkXtSBckSDf8WKPRA+iuZOt03Fjbr0tYtw=
	=
X-Google-Smtp-Source: AGHT+IFrMBW+OhCnT9icBam/s/vk6OKWe4X42OWK7ynSC2VTQQKw5GLkAoEuFIfZ1S6J7yhnX5gf47Hang==
X-Received: from edbij24.prod.google.com ([2002:a05:6402:1598:b0:5de:504d:836a])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:234e:b0:5dc:80ba:dda1
 with SMTP id 4fb4d7f45d1cf-5e4d6ad7afcmr43438170a12.9.1741080366105; Tue, 04
 Mar 2025 01:26:06 -0800 (PST)
Date: Tue,  4 Mar 2025 10:21:20 +0100
In-Reply-To: <20250304092417.2873893-1-elver@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304092417.2873893-22-elver@google.com>
Subject: [PATCH v2 21/34] debugfs: Make debugfs_cancellation a capability struct
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@kernel.org>, 
	Jann Horn <jannh@google.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When compiling include/linux/debugfs.h with CAPABILITY_ANALYSIS enabled,
we can see this error:

./include/linux/debugfs.h:239:17: error: use of undeclared identifier 'cancellation'
  239 | void __acquires(cancellation)

Move the __acquires(..) attribute after the declaration, so that the
compiler can see the cancellation function argument, as well as making
struct debugfs_cancellation a real capability to benefit from Clang's
capability analysis.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/debugfs.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index fa2568b4380d..c6a429381887 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -240,18 +240,16 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
  * @cancel: callback to call
  * @cancel_data: extra data for the callback to call
  */
-struct debugfs_cancellation {
+struct_with_capability(debugfs_cancellation) {
 	struct list_head list;
 	void (*cancel)(struct dentry *, void *);
 	void *cancel_data;
 };
 
-void __acquires(cancellation)
-debugfs_enter_cancellation(struct file *file,
-			   struct debugfs_cancellation *cancellation);
-void __releases(cancellation)
-debugfs_leave_cancellation(struct file *file,
-			   struct debugfs_cancellation *cancellation);
+void debugfs_enter_cancellation(struct file *file,
+				struct debugfs_cancellation *cancellation) __acquires(cancellation);
+void debugfs_leave_cancellation(struct file *file,
+				struct debugfs_cancellation *cancellation) __releases(cancellation);
 
 #else
 
-- 
2.48.1.711.g2feabab25a-goog

