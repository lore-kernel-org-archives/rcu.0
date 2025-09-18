Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6172A31065C
	for <rcu@vger.kernel.org>; Thu, 18 Sep 2025 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204364; cv=none; b=sh20s2q5wl4zLeOBFxI2aHncdUXiDMmK3w5mydDVdZctHrRsDFPRzYaNvjQN0e7rflm7y5FSX/LSV2mpaUtP/xI2uam1utg87LypcNYF+1posyszNlzY8fKYPXhl5scIrBu5dSbVucF2k1d4K8wG7+ySNFA0ogsuWCoUfHWCe1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204364; c=relaxed/simple;
	bh=/5HhdQcxMvAGlf0Tsk8GdQh2Mls549x0+PiJde1VHsw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QM2VGNp/Pe+pOSEcfROI+92ultdZUgzHWXN6v3v7UJBeUIREOPAOXSJVzl2l2rZ+pxwxnEPgMAWmu2sONgfWTnuApUlmGxJ4V153vOMP5tfTTZ1D/DV1419MktSM4pxJbw0JYk34815vC9mLmV3/LVLS8WiysmJk+Rz6Ainz2lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fu5tYxIF; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fu5tYxIF"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3e997eb7232so453691f8f.3
        for <rcu@vger.kernel.org>; Thu, 18 Sep 2025 07:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758204360; x=1758809160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5lBqaGhUvOv+7EeFvUiY/U7KvKRahgMMUHhFj4QhTCc=;
        b=fu5tYxIFzwau3Xm1wdr0WGRp5ptZCJAJQVTlKpZwqrCtlICyGAjF7UzjqvBwHsdaLP
         Kc3cVxXFggh+BePUS4Ya+lROGTLBQ6uyBkKGG+4EWlFeP2lofLzLWDKWA0jKO5AtbPXi
         3u/TZxquGICV5ffmgTzU+LnepwblIAkqXL31s1cPxdRG3ZlbplVqrdQMmsYdwxbe/eRE
         3cm8wba1+q5PPQCOx2c4EjO2s7G+czYPBxoGtfo7AWsyyqa8ExPzkUPHiCOz9+i/IuZ9
         /T7ktlHM7wqGFqSJFOi4rQ+tq0TaDFEy9v4kN+4f34aMiRrUv+fOXeM98MD7hHAyrqWz
         Td2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204360; x=1758809160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5lBqaGhUvOv+7EeFvUiY/U7KvKRahgMMUHhFj4QhTCc=;
        b=XZ2buIip6e0amJrogZPfZAlkDmIkJdmh4gifv96cwFHLOglI2MhHri7yIuaIp7FiAB
         W90UQQGocwRVfrF4TmKNwLSGr7MOt6fys8IPwEG7t97Ov+nT/b4blJe55gVSOn86scgc
         9IsVieZCGmipHsREdyEPO9W9KMpTuKp8PYQ9B46hV4EhL/0K/CNZLU80EZmALlsdFewj
         YpstUBzOqtxVSq4mmDqvTg9MVU6yQ4MlKFfQxE80wqumHJ1+Sp3xFDUu9vHxSq9YCn6u
         135fwcyixIPjgVnRhV2JmHSFYWE4f69gUUhYjj2eue5hP+z8EdkkWaaHGKsdeV0nmnPm
         VzRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhBC35lc1kvKQbIPJ7oUlLiaoPqi6OUxdVK4LqL18PPjn3uDRC5XY4ke+0iHtrY9UwTo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu2zkgspPE8zWzMx2BwIEQBD+y+g3bWLFSRgVdfFR672EiEirs
	s4hLWtRFYV/RVP5kzS/1TU221U+pjUYWFhxEAD/fIISh8ujGmxPz657nxdNhaiFDUU6qGrVHARb
	/mw==
X-Google-Smtp-Source: AGHT+IHiULKUOB+EsrBDrVl5HZcjneDq5C1ugpdpG+JWPfxVb71lR0xGZgLTOsEBDQp8WA+TeuGcjvm7Gw==
X-Received: from wruk7.prod.google.com ([2002:a5d:6287:0:b0:3ec:da84:10a4])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:40cb:b0:3ee:1461:1659
 with SMTP id ffacd0b85a97d-3ee146119c6mr1267126f8f.31.1758204359630; Thu, 18
 Sep 2025 07:05:59 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:59:23 +0200
In-Reply-To: <20250918140451.1289454-1-elver@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918140451.1289454-1-elver@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918140451.1289454-13-elver@google.com>
Subject: [PATCH v3 12/35] bit_spinlock: Include missing <asm/processor.h>
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Christoph Hellwig <hch@lst.de>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Including <linux/bit_spinlock.h> into an empty TU will result in the
compiler complaining:

./include/linux/bit_spinlock.h:34:4: error: call to undeclared function 'cpu_relax'; <...>
   34 |                         cpu_relax();
      |                         ^
1 error generated.

Include <asm/processor.h> to allow including bit_spinlock.h where
<asm/processor.h> is not otherwise included.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/bit_spinlock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index c0989b5b0407..59e345f74b0e 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -7,6 +7,8 @@
 #include <linux/atomic.h>
 #include <linux/bug.h>
 
+#include <asm/processor.h>  /* for cpu_relax() */
+
 /*
  *  bit-based spin_lock()
  *
-- 
2.51.0.384.g4c02a37b29-goog

