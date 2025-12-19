Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965D7343D75
	for <rcu@vger.kernel.org>; Fri, 19 Dec 2025 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159179; cv=none; b=FhtegNO6I19Qir9ZvNY9UdKmBwXGLvgV11iMQbtsacuHQjuJiOyHCnlMn1f7c+T2ALPyYpC45mXYUg3tWQFZXzHeYFAhX+TXHbKz4rldB6I4BdRh5bvOZ0Esi2sl/vAVmZBci6GwLcpX01ENDtasSko8iqQc8hXKYoTLc/6Mtc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159179; c=relaxed/simple;
	bh=UEZ87BxP3bpICDcmger+CGP9yO2gKJF9FSIT7SHC+TA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KG1rOzYPBl4TXl8hTjSJiDSIEY2cu6EVh375ABVNZOAn9Ausr+yiNwYKKlOURGkgdQ+l5KQO9/qz315al0oW7IJhlmPTyK3U6wEuPeqxcNZaKrw1QKJ91HCpETgzm81fpXcAda+8jR6UwqwJGJj4xlSRl5dkOLF1BAQs/8sXJO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=20xkXXuA; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="20xkXXuA"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477cabba65dso11088025e9.2
        for <rcu@vger.kernel.org>; Fri, 19 Dec 2025 07:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766159174; x=1766763974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GzqxblqNylMZssrhkzyYMNb717UQfTl85zNKlM2THvo=;
        b=20xkXXuAhACSentUBjEFwtAg+/OPXumpmh1MGs2zcpLZqfjv1WIaoHLMDEIQRb5C6e
         6Ut7UPEwYmS+2PSh5nVQNlksCPgJQw0RlfkQCLkgbVCMeTZEw7vr7emat5d9X11CWuLc
         umHOgN4R5SlQPLCelwmxJ9vdMZvDRxwpqIz1R6sM4FTSLz4efpjOQy0wOL3QeR/wrm1q
         XYcpBUDNRp5lF3JOLl/xMeYkxYxfhRelWta1hCs1Z264sjy0M2vzrI1Pw9PD5zY6r7L1
         J+o/Zluws6fXB1GFwNEBgFTidsvdF5EfX90lrvitpLRo/7rBexsfGp51lTW5wWYu9tiP
         5QdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766159174; x=1766763974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GzqxblqNylMZssrhkzyYMNb717UQfTl85zNKlM2THvo=;
        b=IRfWyS2cMJ1vX7Ml4wJtgvCHDTrvYCSZD3TE0A4ANzMED3k9HHzjfJ0n/U5CFLfkGM
         ZLkH7kOrHFr/2D2B4NRpTy/m8GCZ2O8L9hikAxAvC4xm7rLqIGMfYVj3LE0OC7jlvrOu
         GtQLnPW65wHztlne3uBCp2AljY1968CAQHgG0vJI37Qt1xQHUZViWD9eaHNLSuvvVZv8
         dhsdMy5bR7UGWWeOPR14gb0I9PE1e5Yp07U32iDYf76vUUvUhjihurKg+IA9XvjWb9F2
         Qh5WTipzrvGtdPj0g3bqfI67EHUQcR1yIo6RVMCrqlo46kfCIWxDqviz0HAkUdIgmGf2
         7/Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVXy5bM2cngB+MAzaYWHcxwhlAC1Fd9rLmX5ceLij6w9qEZYyn6Rn8W7UrCD0oHdyZZzbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwDRd7dgwub8ZtfdUDh9yjqJqdbnBgmOa7ShvuF8W+uHWhsygj
	FYPvuDaDkGF2lRVWoyO1PHecF9R7H4HRILUKWSCOqYwOPZjgvMMB3AUxhFzbEoyBxAqr95ykBOs
	FSw==
X-Google-Smtp-Source: AGHT+IFDBzha0VLOsownpeE3/oX+GYClWE/LTUckt6t3nGkH3udhxqzAfrWi3SLQ1c5sHOt4XQ+QWDn3uQ==
X-Received: from wmqn17.prod.google.com ([2002:a05:600c:4f91:b0:47d:1d7a:6d40])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c494:b0:479:35e7:a0e3
 with SMTP id 5b1f17b1804b1-47d19582aacmr29774555e9.30.1766159173561; Fri, 19
 Dec 2025 07:46:13 -0800 (PST)
Date: Fri, 19 Dec 2025 16:40:01 +0100
In-Reply-To: <20251219154418.3592607-1-elver@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
Message-ID: <20251219154418.3592607-13-elver@google.com>
Subject: [PATCH v5 12/36] bit_spinlock: Include missing <asm/processor.h>
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>, 
	Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
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
2.52.0.322.g1dd061c0dc-goog

