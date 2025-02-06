Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608131F4174
	for <rcu@vger.kernel.org>; Thu,  6 Feb 2025 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865902; cv=none; b=RDnWtI9403aJ8K9hdqaVQ+Yga5+IZshEa+xQIcAnrUvdlSafcJJsjj4GTQezI5zUazQtEshF1WIyd6hCAhQaB6K+tHUEickIdBwfAnPxuSyQNLV741cyUdYWWDJnG22ST405eShQgrfTT8nXdsSHo6UD5rddEuXUEwsojGNiIRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865902; c=relaxed/simple;
	bh=Y9ecdWWtlfdxtG756H0/OQ3twmMuyLw5QPOn7VZx5xo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Eovo/Porz7KDsSqt7WxkZMSMJ6uxdOPg3RmhCF7PbWOGtqDRS5Fu/ZCxIOqEHt3OPJklKRuDOrRJ5r0YyQNLST1WSnaI1LlQROdS/qGir4Rh0WzHsxPHCsYpRSFyTc3DSpqWPuPj7tQAn2yQge4Z0rliNMH8uaScKV5oFcI0Muw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hZPTZHaf; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hZPTZHaf"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5dc6714f3e8so1735850a12.2
        for <rcu@vger.kernel.org>; Thu, 06 Feb 2025 10:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738865899; x=1739470699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nywgR7jAINvHiuDVB4pmE7YTMO7Utfq2UN01exAeezk=;
        b=hZPTZHaf5WSPoU5yoeyyjfqebZFC+khtx+219AqDn4G87F5WK08nKW9aOg0w/I7rbO
         6B3bQXvYKm43fx7QtrWXBb3gXMuhxPdD+cybNbdsNS36X1BNNaomTroeqtZsumn++iPw
         XA1Booery4+/REIbSd4fvGc68mNnKi6SMrxv7DoP3iolWp++2pm819CnBFhkkhYcDDXX
         4gfO4z4RWJgnGrs+7073pvdNeXEAv/RiG5Rb9eF1FdmwYwdoIQxLvX2q6PDogaQJW9O8
         1s98iEBrTHKoA+3eJIODb4YRj/YTvE4t43efauXfVBvCJeMFg/6MH7n44T5z2ymUPsZp
         CvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738865899; x=1739470699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nywgR7jAINvHiuDVB4pmE7YTMO7Utfq2UN01exAeezk=;
        b=bNYNHYxfPZpyEUBAWXh2gT4b2hWQUZIjWEr9HEZ/VspD3W1GxpYueT9XDUs5AlOkzr
         b7lIheW59lLVbWIh/ZCIpwN3Q/kBEKdBqNbmLkvchENkLouX42D25GvQEROAlG0LK3fb
         +KQs+U6ZNkYuWv+j/bQHgjYO4sXp9MIh5nIPNIGAhL91mugZrz/ckca9EBOrapoSDSRP
         ipBq441BB7BDzc937aGJpsUDLoXhhfixQIKAgci7e2pR3VT2gI4KpgrO4UaSiiHiT9DC
         Y+DiPsgObQyS6AZ78ajkSc8uq7b7j9XsomhI68mv/2VMV4rRQjFOSuUmkhp3upYgG7Dl
         690A==
X-Forwarded-Encrypted: i=1; AJvYcCW6oLKH11kM/+/pghXDTJ6GuAuHwBsq/KV7AR5Lb28V5Y3n5pFwovJmlhnfQdR4Kv6lBc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNZAElp8Jji/1oombAZMcjhJUbdGCnksN19qkPPkn8aYx4onIH
	f/ea2UbgGqRyWB/sAslKuENHbTWmpFMurVoyykxtTIMoK6qJIdfJDldirQxddYor9CIPGvwGnQ=
	=
X-Google-Smtp-Source: AGHT+IFTk3UeF0W3iesDJF4EyACnSXH4BTQBJaMsRlkE8Y124Sbz3T2V3DVtoGu6cpwiCqo9TIV5lxqZAg==
X-Received: from edag6.prod.google.com ([2002:a05:6402:3206:b0:5de:3ce0:a49b])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:51cb:b0:5dc:88dd:38aa
 with SMTP id 4fb4d7f45d1cf-5de45005a73mr490615a12.8.1738865898851; Thu, 06
 Feb 2025 10:18:18 -0800 (PST)
Date: Thu,  6 Feb 2025 19:10:07 +0100
In-Reply-To: <20250206181711.1902989-1-elver@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250206181711.1902989-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250206181711.1902989-14-elver@google.com>
Subject: [PATCH RFC 13/24] bit_spinlock: Include missing <asm/processor.h>
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org, linux-crypto@vger.kernel.org
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
index bbc4730a6505..f1174a2fcc4d 100644
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
2.48.1.502.g6dc24dfdaf-goog

