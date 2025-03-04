Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8131FECD8
	for <rcu@vger.kernel.org>; Tue,  4 Mar 2025 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080326; cv=none; b=b6JxLledo+G8DM0Nbm+lp/sC4OTjvzAGAmsjoaYE4Ql5un3CcltKLQz4H/mexUa/bg7dI1qgDPFAmmjqYyhfzzHL/OwM3xExZvUL4T3U7Fzo/iKM2wtJmXpQ0O1RJmGvdeEbdJ8Mj9ecQ9TtuIPr4XQHixSJ8wK4pP1V6kP+xXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080326; c=relaxed/simple;
	bh=StYpncqzFSXHEYm8ZOW/8xsOKbkMA3l0kvQy8Snle/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FSxRitt9bk8kINMaUaJRCJujOM7zxVacjhA9zYchvQDa+idkg1593Id+0toTrigfgth5TLfgy5DiGdl8dciLpcMVIXG6lsOHl8o3Dj8qKeJhI/TbwhUDOEZ/VLcE7YJ+fqsRNukSpGuSqiQurCX6GyQqIAUVDm3aCaLM9beUIQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=scVZ+iz5; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="scVZ+iz5"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5e4becb4582so7133077a12.3
        for <rcu@vger.kernel.org>; Tue, 04 Mar 2025 01:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741080322; x=1741685122; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pp+E8sKoonvgdGAMVoQXSiL/gMXgRdJZHQEkz4wDB8k=;
        b=scVZ+iz51d3NKfYcrDAT7foKOBgwosQbwsV6wvyQNI64abLBrDh3kInDKqEL2XZ2yI
         i/QZrCOLpx273bv8NHyFfMkQaEWrn+gVldrsOScezd369MRxCkFon/5fDKG3/J6LLe2Y
         /Rt2C3SRfGIkS4ckhqBpP2oarSPq8DXVGzU83CN+VTEPdX6PELSIYgXMFiA5JrRwOvRw
         qJcNkstNO1s+24/ilf3YPA860LBYfj+jGrKgER2EpZJ30Mu3wnVVCtrUgCVx+9zW6f58
         bbuk0W9+4Yn8rXXv+O7ED6LSWG+ZGH4EFSkSprX9pQazlOX1H+ktLbCGNglRfh7f3OmK
         q0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080322; x=1741685122;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pp+E8sKoonvgdGAMVoQXSiL/gMXgRdJZHQEkz4wDB8k=;
        b=q3juYUTE8+uosBVBoCmO+k/wzk9AQY4/fT2s9HHT1jqVBWgA3D7dOCzbXvFrua2QXL
         7JsB7hkIUut0cRPtAK/mwySxHCvODrj6r01VycRh9ZpaPIhMLR7BrFuAhqGh6kV78tRO
         BZ0eC3p+o8SKBdDpdBeBFSp+vCzj385xcsvY4ZSQERfD7b82MYWCjtyZDXZRRTx8rUI4
         oKAaQ8w0SBPM+hAsXnocj2q5nuNglERkDz8Oi+7p6x87mYxUhkgNy8zInAk15D3uP6Y/
         GtvpaRbVZ1rXSXhxpIN0QU7dpp42O+nM0cQ5ta9uV6Y2wMsbQlw2reFRoOnR8P2UcuZr
         en4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfzYWImOSqyHnwTenTeddthzk9QNfW3XEtc8++tDazexshk/oqE9vrotnW8REf8xg8pM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTZMuEVs4LAFIolal9pSpl6aQaKQsiMpeQuYC4dqdLK0fAmTK+
	RLCXiqrNc48CnvhtnwzWMMyaTFQPWKuP3emaCgEmaLTkq27SdyokRi8gTNQShA9pbd7/DtFAGA=
	=
X-Google-Smtp-Source: AGHT+IH9KyF8MJ1v+l119Ih9d9zKK6oLF4W3jM8vNIisJnYl0p8zp9JkukwRd5xgRYNmt/zF9O2bCVvi1Q==
X-Received: from edpr11.prod.google.com ([2002:aa7:c14b:0:b0:5dc:578d:62e9])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:3487:b0:5de:3478:269b
 with SMTP id 4fb4d7f45d1cf-5e4d6b75ef2mr15880706a12.32.1741080322290; Tue, 04
 Mar 2025 01:25:22 -0800 (PST)
Date: Tue,  4 Mar 2025 10:21:04 +0100
In-Reply-To: <20250304092417.2873893-1-elver@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304092417.2873893-6-elver@google.com>
Subject: [PATCH v2 05/34] checkpatch: Warn about capability_unsafe() without comment
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

Warn about applications of capability_unsafe() without a comment, to
encourage documenting the reasoning behind why it was deemed safe.

Signed-off-by: Marco Elver <elver@google.com>
---
 scripts/checkpatch.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b28ad331742..c28efdb1d404 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6693,6 +6693,14 @@ sub process {
 			}
 		}
 
+# check for capability_unsafe without a comment.
+		if ($line =~ /\bcapability_unsafe\b/) {
+			if (!ctx_has_comment($first_line, $linenr)) {
+				WARN("CAPABILITY_UNSAFE",
+				     "capability_unsafe without comment\n" . $herecurr);
+			}
+		}
+
 # check of hardware specific defines
 		if ($line =~ m@^.\s*\#\s*if.*\b(__i386__|__powerpc64__|__sun__|__s390x__)\b@ && $realfile !~ m@include/asm-@) {
 			CHK("ARCH_DEFINES",
-- 
2.48.1.711.g2feabab25a-goog

