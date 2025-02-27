Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBDA148857
	for <rcu@vger.kernel.org>; Thu, 27 Feb 2025 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740639625; cv=none; b=BBTUWjWaH1pOUga/SgRmuQSvaRFIeAqFsKZf5PcrFkwuHrQ/X3dJ+B8ehGmUjrpWu5pcaZmw1pwpoDMAUyIsFtdDMUXNB2xboxDlQD4hPrdo8zWmdbB3OJaoMNHsPReukQJ+j26tpwFXR3F2SC/lVVUOefw/xiV6C+j2GXZ5s3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740639625; c=relaxed/simple;
	bh=Ah0Ok8u2jvwbArCTA7l4DjY9WAjqP5uUmepnny/Z2kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHHX5oLrP8yG1Rp74vq/Y3326DuBiU15ihh72Y6U1CWgxd8+nIbQsrY4qTBR2Dmng/AFyg+EW1glM/afrmGUMPXftRVqTvW+x7UCR1srtqapNrPMaXryjusYm114QRTeV8PT3NjjxzqUWJwA7RS6tUqNJyS4xUe+KsWg8pcl1Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LuKokJ7D; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LuKokJ7D"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fea65dcc3cso747152a91.0
        for <rcu@vger.kernel.org>; Wed, 26 Feb 2025 23:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740639622; x=1741244422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3B7a9PKqDfPLxt+uZdMSLJc6wZgnR8JO787nsEWqq0U=;
        b=LuKokJ7D9zG2/XGscU4kMDnfTJsPXxCjq2JaNkS9yY0qLXIL/1U6KNMeu7uMJP574R
         pkrYS7LM6m0jClsNvt3YIlqBZfMy3qEppQ0Xtc9z+sM8cRRTedhb2FZp3zUAg4y+wkCF
         zARfalQLaGf+FVHUBNqBg06TaEIhRz4X1Hwc0AXfEuF6kHg8QIhAP6zuNKYqpCIaRs0z
         s3PuUnsllVcv+7dAEnN9VP36L7vtRQ2vpTohqpLN3BrzdjGRsFZtaQPqpy9IDRJ3foTX
         M2B7fe+tBkSt2h7USbBzb4hBKIVfWapzl4EDTMykeEjqMhxpdi3vPz9curMgrsfO7g3J
         BxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740639622; x=1741244422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3B7a9PKqDfPLxt+uZdMSLJc6wZgnR8JO787nsEWqq0U=;
        b=hbzuE9ne+BCBTfY9c04Hpx3Ee1vJxWGphFFN4aLykjfwPM/k45LgEWqlkzMgqfEKHg
         hf9cC1pdoq6zukoqy6sp8tB4/T8f/41UQkrhTd0oK7OgHA+ZUWgFMIGZ4tpKNG5kU8WG
         iOSMQNeksr+4zEaGEF6oF/b3iqUK/tKcF6BaChyAuVVxVuvQCAI1w59NKFikz9coWvxJ
         ULxfNhDmaz8aK7L5wc9SC8XnZVDcvSNZU8nxgQEML4Z0b7sHnh1ROsB5xBNCrPw916sP
         dNEnqwSG2g6EVvMBJEep8Jr0m/v40t6BBMzxLepW+rWlWXwfTeQXMxuGZ7mPOlIVMKiy
         HKMw==
X-Forwarded-Encrypted: i=1; AJvYcCWh3lbVocVKCot2mb0BhxF9CdohfxnabE8DEw1/jK/0X/cYI64+mrjrDoWPfytCm6ZFFZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4wfhMvWpw4VDgGynh2uNs9Xqgiyb6i4cq+TOkq/IAgEaAngOM
	eLVruIgDGrJ5U4vbYrHvVnD10hoocu2cj2MFReDObR+LW2wtvbjIl44evO4and9cDqj5Jo0oPLA
	oD3feJNEXoqydBcsZOZ501Q2+EfPRrDmeEyNG
X-Gm-Gg: ASbGncvxbRW7MEhVYrcSdTNB+0y84XGaVp9GFZCj/45y1E66VFBdX3C5/8845d/SEoI
	7A8wlCB11lolp9RQJ7g95fxTj695nvcQQ7ARuoGj9GQxnOMqF7nNDKIbcg+Ru0z48AkO9jNFR2Q
	S3MWVRaR4Q3BOybeM9YZzsKV4ct2r/SQmqxJslyg==
X-Google-Smtp-Source: AGHT+IFfzszcK8xz3AbKXR7cq/ASZditUq/IPM5LeqCUO3BVtZeQjerGEcaCp84fg3Mzv4RyJIt8ZyiiSg5FyAUsE5M=
X-Received: by 2002:a17:90b:5148:b0:2fa:17dd:6afa with SMTP id
 98e67ed59e1d1-2fce86cdeddmr44583103a91.17.1740639621455; Wed, 26 Feb 2025
 23:00:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206181711.1902989-1-elver@google.com>
In-Reply-To: <20250206181711.1902989-1-elver@google.com>
From: Marco Elver <elver@google.com>
Date: Thu, 27 Feb 2025 08:00:00 +0100
X-Gm-Features: AQ5f1JrZWnMR4OE-NBvXmFaojOYjcgWnnmEzRSN2Q8FKZWV0JX5T-ip-Qb4DfME
Message-ID: <CANpmjNNxb8f4QNQE+3oprwfhbhZNkiN+JJMRAzMa8mHXFkksow@mail.gmail.com>
Subject: Re: [PATCH RFC 00/24] Compiler-Based Capability- and Locking-Analysis
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

On Thu, 6 Feb 2025 at 19:17, Marco Elver <elver@google.com> wrote:
[...]
> Capability analysis is a C language extension, which enables statically
> checking that user-definable "capabilities" are acquired and released where
> required. An obvious application is lock-safety checking for the kernel's
> various synchronization primitives (each of which represents a "capability"),
> and checking that locking rules are not violated.
[...]
> This series is also available at this Git tree:

   https://web.git.kernel.org/pub/scm/linux/kernel/git/melver/linux.git/log/?h=cap-analysis/dev

I'm planning to send a v2 soon (Clang just gained
-Wthread-safety-pointer which I wanted to have committed before).
Preview at the above tree.

Thanks,
-- Marco
