Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F573191DE
	for <rcu@vger.kernel.org>; Sat, 17 Jan 2026 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768656571; cv=none; b=Bh8hlt16JcbsSAkja6ocPdVAjS3Wv36d+niFO0pY8aNMM8UzTKQ/btZBxHbc8KGnWPPhET+jZTWVvvwzREtNUJ/DgQQQ9XA1I/WFtL7vA4KaC8wz5p7sge8ZJWvTBO8gw/KeiS9sL5fLJLyhwb/5NufkGVuYPIqeVKvB1chXWNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768656571; c=relaxed/simple;
	bh=yGX0/BmN4QSqMec6LsJaLEgukSwhg32D3RH18NXGaE8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=huvyMnAJGAMtknxT6o7xfyeCPVPcioV5eBxSj6nRW62oNZYNb21CtgRm/YZbY3rzDMC8Ius5F+Ufc2WqLmvU3X6teZRYSUiOdpOuJt4VvPwM9IZhf1Mq83pddtXdFTkA3s7R0y8H//vaf+qoAsh/b0zyFq1OVh578ViZDH331jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OMmoqa4z; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMmoqa4z"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47d3ba3a49cso31527495e9.2
        for <rcu@vger.kernel.org>; Sat, 17 Jan 2026 05:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768656567; x=1769261367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yGX0/BmN4QSqMec6LsJaLEgukSwhg32D3RH18NXGaE8=;
        b=OMmoqa4zagEyy7TtwRhjLszgMA2QqyBdA0uSwG+DMytf4uLSA3VnypEjrM8fvx/dTf
         HtHD+cvLn49bOCxh/fMtupnz+Z4r18KevyNKGkZo3hT3l4iDdkyuTbuWVFjM3z6DSGkA
         ZmIi0WjkrvD1ghTXhnVZnlrr94B6ZhzEctkIEN48wISPtlGUOsljfHTvOFtCliyfBqb0
         uljFDcyEqAX88ZPDQKqZ6CYSDar2SJ7KqHit1lFaZBfQgLXEAsKLU5NY1DoriZaw7/sl
         Bua8Hwk1jGkvsmEt7tnFBrvEW0caMtgGFcLLYtUtqw54lxZpF867PSit5C9aSwRtCSpP
         3ZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768656567; x=1769261367;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGX0/BmN4QSqMec6LsJaLEgukSwhg32D3RH18NXGaE8=;
        b=aV7AvPRaRCMRf+OqpiLgDWySEXcDQqWFd37DOAvT/P+UmcAoxuFwQKDIm6JIehKvHK
         wTY+KsYx9+QVKocM18fb3wq0FpvzcdrURnMpzZt1ICsXmiULPAcjxxBmqKpXv3KLu8ef
         sltmtDKdwV2w/L6rPQHKw5qYNS8/8qHdgqgF3d7Z22/dzTxRR8xzDLZ5ZUeazFIuYuy+
         egc7b9OweSUarfav1JKF8xxz6KkcU6prr90beNtip+z2wxAM+ZzZ0VgkVrhQ8VuM9pyF
         55Oy9QMlh/p9iPsXuZsT/iaY3q6YljXq9e/JC4D3ZMrvnPZUJSnLhyzaC0C9e3W1XzUt
         hbeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDJKcXU2JLf5q9D8ZvVDiK2Jahi3tCQykm1WDUQ2xsWxA+PfQfRv/spTkWg4mUU1sWRng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1+j/wFIPaWicyywfrqOMaGOseseg1o/89L0nmXXTgQowjucRY
	XwZ0FZtU+ufbIj7JoFOz+JCDlPm3+zoy5MR63/fGmAB1TdviQSZfU6KRLIPDvUmlFn1CuyE+irK
	V3TY/Y8JI1xvOUHBe+w==
X-Received: from wmby1.prod.google.com ([2002:a05:600c:c041:b0:47e:ddf0:fd00])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35d2:b0:477:b734:8c53 with SMTP id 5b1f17b1804b1-4801eabf1c9mr75158475e9.12.1768656567159;
 Sat, 17 Jan 2026 05:29:27 -0800 (PST)
Date: Sat, 17 Jan 2026 13:29:25 +0000
In-Reply-To: <aWuKlR4a-VJhBeWj@tardis-2.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260116-rcu-box-v1-0-38ebfbcd53f0@google.com>
 <aWrSkAPFkdH_tvtN@tardis-2.local> <aWt4muGXbe7lBmXt@google.com>
 <aWt8Ze-otTkexNIe@tardis-2.local> <aWuKlR4a-VJhBeWj@tardis-2.local>
Message-ID: <aWuOtUa0mPDrnbke@google.com>
Subject: Re: [PATCH RFC 0/2] rcu box container for Rust + maple tree load_rcu
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Andrew Ballance <andrewjballance@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"

On Sat, Jan 17, 2026 at 09:11:49PM +0800, Boqun Feng wrote:
> In Rcu + RcuOld design, RcuBox is just a Box
> because these two pointer types handle reclaim + accesses.

How would that work? Dropping my RcuBox<_> must use kfree_rcu() or
synchronize_rcu() or it is unsound. So it can't just be a Box.

Alice
