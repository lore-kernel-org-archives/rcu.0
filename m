Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8030241DEE2
	for <rcu@vger.kernel.org>; Mon,  6 Jul 2026 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338922; cv=none; b=maIPdxVloShBxVIVlyz0+LofLLTz9YOCZuPVDgENut3Z1lhHNduraWuNAcUHHVIuJlY/nhQ5UuNMo2gzJ1cmNecuBhKkQibSYwzrClEQN6P9yqRwhsc8hrq2P6SzdWUWTX8liZlUB24qyxdyY1dEPbC0bHPO5Iem7/vax4jZBj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338922; c=relaxed/simple;
	bh=KEJuQka/lAHPOXYTPGsjyTGS14JS8/uSiPEYD0VW2SM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ERr+OzocjaK000Bzxt8sVdjKQsyIz4pbbrMT+bZFEdjB6YjqrnvD5+Jptv4fKf9YaeXN2fCK/7+fzRTPWamELlzeMOspB5pviCCI6l8XagRICKyHRS4RD7TjKGl0UALxcg+0Z51BLfjiCSuRZRHLbgUGswwDH2plr8m0Ju91Xa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uSN7xqnk; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uSN7xqnk"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso23498345e9.2
        for <rcu@vger.kernel.org>; Mon, 06 Jul 2026 04:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783338920; x=1783943720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GzTwFKT3REdJ6G5TZ0YBDl2Hm1+LCDk4PNVrne4DR6c=;
        b=uSN7xqnk7pglCGzZA3+zabybvU1be2oNlPjXzag0Czr6+3vr+fa9VhxhSB63T4lBJM
         puDU4C6lTNreqYe3sojxCEv0EbpKBtpFtBbHD9oKFq6AbOdJRYP3g8WJu+rjhYzzjVEo
         ibTAOQbbAodkLe/OYkTktQR39myu2LA0/ujrT/kVaGupwqOXS0Rt7EdpuSaLO1fXxvEa
         FAML8G4dJxQKeLL/A1v2tXLm9fq4/f3V3fytVk0MrjEpp/S0osojN4qG77D84YfdpHsa
         hTldNIpjnBjZLcZvWwjPYOrglV/gkUO7v43KzrEH4jn0jt6R5j7qKo7zSuUkwm7U1ykH
         vsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783338920; x=1783943720;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GzTwFKT3REdJ6G5TZ0YBDl2Hm1+LCDk4PNVrne4DR6c=;
        b=M9nuDtKkzOpI5NVXn4ImVGcWYPeYeZHiY8w2f38R55lTpfmh+526HvtXPdWUQ4vLrO
         2X1+T9bS2pYnnDQ49+BuQzIRLl38iKQbpOO02Xz4ysUYtrmm4ox30cx47KZUr6+uDRUw
         +//5qAv73smHrMaOoMp47YizRjTrie8dECwcOrhIgVJMZZDLR7VfJvtsYf8WD5bLEYlb
         VQ/q5xIQUd96GCNRKE1bd5F2eFuNuxS+DVel+zNGqVHFvcl0gZC26QLAEDGSGVC37+MG
         l8WR+eBFspVvb09z47ImVKjJ2/aaKFrPyz8We8VALc15b0b7mIIUxPddmsYlTIinPUUS
         QQLA==
X-Gm-Message-State: AOJu0YwmrygZVgUa4CPElGGACMSnUx/jWKCpOa2TPvPMm5sbAeg58czV
	sECjwnIyOUk7wDhQjWCwl4VJhgNaTq57M52C+Exv5/pWBCI63CDlm5/miephfQ6+8SiBVHpBYGl
	8MZZErCG/tlfSQp/shg==
X-Received: from wmjl19.prod.google.com ([2002:a7b:c353:0:b0:493:bdba:620b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:34d6:b0:493:aa0a:45b0 with SMTP id 5b1f17b1804b1-493df08f925mr889185e9.23.1783338919855;
 Mon, 06 Jul 2026 04:55:19 -0700 (PDT)
Date: Mon, 6 Jul 2026 11:55:18 +0000
In-Reply-To: <20260613065348.96750-5-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613065348.96750-1-work@onurozkan.dev> <20260613065348.96750-5-work@onurozkan.dev>
Message-ID: <akuXpnwb_y4R7ekV@google.com>
Subject: Re: [PATCH v10 4/5] rust: sync: add SRCU abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>, boqun@kernel.org
Cc: rcu@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org, peterz@infradead.org, 
	fujita.tomonori@gmail.com, tamird@kernel.org, jiangshanlai@gmail.com, 
	paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2026 at 09:40:10AM +0300, Onur =C3=96zkan wrote:
> +#[pinned_drop]
> +impl PinnedDrop for Srcu {
> +    fn drop(self: Pin<&mut Self>) {
> +        let ptr =3D self.inner.get();
> +
> +        if crate::warn_on!(
> +            // SAFETY: By the type invariants, `self` contains a valid a=
nd pinned `struct srcu_struct`
> +            // and `srcu_readers_active()` only checks the active reader=
 count.
> +            unsafe { bindings::srcu_readers_active(ptr) }
> +        ) {
> +            // `cleanup_srcu_struct()` may return early if there are sti=
ll active readers.
> +            // This should only happen if a guard was leaked with `mem::=
forget`, which is
> +            // "WRONG" code and may cause a UAF because Rust will free t=
he `srcu_struct`
> +            // while it is still referenced from the C side (e.g. by `ca=
ll_srcu()` callbacks).
> +            //
> +            // Another consequence of leaking guards is that `call_srcu(=
)` callbacks will
> +            // never run because the grace period can never complete due=
 to permanently
> +            // active readers (i.e. leaked guards).
> +            //
> +            // If this ever happens, that means the guard was leaked by =
mistake and the
> +            // caller must fix the bug. Sleeping here is intentional and=
 less harmful
> +            // than risking a UAF.
> +            //
> +            // SAFETY: By the type invariants, `self` contains a valid a=
nd pinned
> +            // `struct srcu_struct`.
> +            unsafe { bindings::synchronize_srcu(ptr) };
> +        }
> +
> +        // Ensure all SRCU callbacks have been finished before freeing.
> +        // SAFETY: By the type invariants, `self` contains a valid and p=
inned `struct srcu_struct`.
> +        unsafe { bindings::srcu_barrier(ptr) };

Hmm. It's not entirely clear to me that synchronize_srcu() is needed
here. If there are calls to srcu_read_lock() that do not have a matching
unlock due to use of mem::forget(), then either there is a pending
call_srcu() callback in the queue, in which case srcu_barrier() already
sleeps forever, or there are no such callbacks in which case I don't
think this actually leads to UAF.

Thoughts?

Alice
