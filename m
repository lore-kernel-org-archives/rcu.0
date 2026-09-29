Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A0E542806
	for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695471; cv=none; b=Q1qF8Xv8r+CJdVNPBpzeUNrBFoYPQRKumaiAbaIhqjPEmFDrAK5+yJDHEoMZnptqk9eIMVhBty3FIHS+3QxlXKTB6tp2xzAWT8xkazKaky8ZcBKnGVG7VhVyDc3n5SzA+vPsUufTlWgC/gYV5Y6f5h9ByMHNFrHl861ue1Ub5DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695471; c=relaxed/simple;
	bh=UyqxTJzFsBHiwpgeaPtT2Qc3mjNuoQ6QFEr9V0LfDYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzKbl2ablldIQ8YGHntQGju/upAMxB1MCbgWgy3/GMzwqrqHJW8MBtvZ2LaujX0cBqd6GEtZSVWb9P0tk18bIDKjeYO7SB34j+AHB+BdtDwMhWVXpt6Pf2KUYtAZ+vaF71JvIFOoqAti1rpWPewWF/DLxahR/wfbTuGb0oXjaSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IM3dUlID; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IM3dUlID"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-81f707db14cso373256a34.2
        for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1790695457; x=1791300257; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9eZZFPBNxtfOlsCifhs9U8AcK3CT+8uiPgj0yDOTXkc=;
        b=IM3dUlIDu4ZTxvVTkLkmz+/3uXR1gn1lXd2BGGBkD9JLLoneMOb3QcRLDBtF71nEiz
         MqhotuHCdwEBps22WDb0skJNznWmKgEj7rwvSkeA/1QUtvmPcb5NWu4WipOYKucimpph
         ndsUff9lC1pQ8lXMxV1dtTXtp5jZFBlPHuI6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790695457; x=1791300257;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9eZZFPBNxtfOlsCifhs9U8AcK3CT+8uiPgj0yDOTXkc=;
        b=gpXnP1wY7KO4XgIWxDNMgYoZ7WnFIOP/HptbCSjWdQHQpjgxTIa3v2SIFfEGqkKLqd
         fcrdlfwRuY5dj3Wewid5OuQ8TLbFq6Kdgs+NFAi9qPR4tV9Ekk+pc7oq3HRUyeY+c9o8
         fgPH7yEpQOa20OXVtER2zKfKxtsFH9DiLUZVDGR43HLrZKtHzjOZIXkEzDJMInwyx1Y/
         sNNs9yiQRpvCBsCsaw2yYRaRHvoOsJHoXmnBmMqX4GtjvttIcZcTkuAdG1HiP3Nlr4Er
         UN7ocH5VT/yLbUfpwrJC25OEYNROPHaLr7F9jLSJ7OObyd2keCGLLmQREXatIjzv/wrI
         RsnQ==
X-Forwarded-Encrypted: i=1; AKwUvBx3PRksKEGpMnQ1fBFWX5BVEeDnCm3G6ycpjGeAqYVoE5vpp2zvZwFoMS7nYeybqIMyFpk=@vger.kernel.org
X-Gm-Message-State: AFuF++lW6mioMGdDnV3E6qZhDo4FgrDzeW+K8YTAk69+Nr/b2OLVimrI
	KvH63HXcVhynaBA8WxjzUD5IZpC71n5nPmuLDRSeRiNSH7kd8c5OaUd2bniIhh0lbE4w6tEyTPS
	53jQ9HC3vDA==
X-Gm-Gg: AYBFou0F19X2uOPDZIqwJy5DOtWXLFTjMUp1uqdyHNb4dJc+ugblMqw5qFmw+reDClE
	fPsEvz09CMCCs9Oua/38fZNID0plaZx2bBB3FBCpwnVt6wuUhyIqSizHi0CSPofYboB0kX0Dgx5
	p8jniePtU3Z4+QyCTY/58iek6M6SzMu9h5E1JLKi3kCPclFSffR4LYnyNnLrI334X3Bf6LdnApd
	uPq3YKSEf2ioCOoUO0Bs8TwZukLYRWYjTpbuUXugW5QTLc1vVkL1uDpvlh5+0vhhdIwDnZWt58w
	+1igHiQDGuPbMJDiVoGEkX6wIZ3tiwekkcZK/jP4Y/IAoX647cC4OyoRwMbgb97kqUDunf3/guT
	ceZuS2bXdHDqhbtOLqQM7M3Ot4BcPHQvTWNv7cI0Vhmxrkg8pBJ8z1gn1lzdfgrbwvYSeL8u7c6
	e5mht3KR5pTNO9DkIs0R9ujaYTSf4E5XkYO/N6pFi8alUCX4ckIWe9Z2TEDiQCPl16cTXyiKnJo
	cYMu6Sdbl47xPKtiMrEX9p5KA9/SJ4mhGWPCNHgCyOYCUo43A==
X-Received: by 2002:a05:6830:43a6:b0:81d:e300:4c28 with SMTP id 46e09a7af769-81de30f9039mr4161565a34.9.1790695457544;
        Tue, 29 Sep 2026 08:24:17 -0700 (PDT)
Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com. [74.125.231.171])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81faf7eedd6sm173766a34.17.2026.09.29.08.24.17
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 08:24:17 -0700 (PDT)
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6d7e06de06eso1340713eaf.2
        for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 08:24:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy2IAZyPjFPX2jWsdq/mcd75tghhO0sFQ/iYmgz6sFyv2Gdywofa1gv2Or0neNAQygkKgM=@vger.kernel.org
X-Received: by 2002:a17:902:d483:b0:2dd:ad73:5b68 with SMTP id
 d9443c01a7336-2df7da85639mr143411375ad.24.1790695032383; Tue, 29 Sep 2026
 08:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
 <20260927155134.4740-3-mathieu.desnoyers@efficios.com> <CAHk-=wgQyCdrWH3ZuSajOxZqiups6jYbPtqY8JR8OeS7yi49Mg@mail.gmail.com>
 <133ca8de-cf30-4bf5-9539-d0b73e347b22@efficios.com>
In-Reply-To: <133ca8de-cf30-4bf5-9539-d0b73e347b22@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 29 Sep 2026 08:16:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7BkCuzMe_zWi6KHUs09UQWJpCVNvuFg5wh_CAu5dgow@mail.gmail.com>
X-Gm-Features: AclHuK92qcnFUvMDyEty0mgzRt4zpmui3HdPCBaHPsJjfcUlLFRzvquKppDzHHE
Message-ID: <CAHk-=wi7BkCuzMe_zWi6KHUs09UQWJpCVNvuFg5wh_CAu5dgow@mail.gmail.com>
Subject: Re: [PATCH hazptr 2/4] compiler.h: Introduce ptr_eq() to preserve
 address dependency
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, John Stultz <jstultz@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, Mateusz Guzik <mjguzik@gmail.com>, 
	Gary Guo <gary@garyguo.net>, rcu@vger.kernel.org, linux-mm@kvack.org, 
	lkmm@lists.linux.dev, Nikita Popov <github@npopov.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Sept 2026 at 08:04, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> I agree that doing it in asm would generate better code. Also, I've
> been told that clang now preserves the address dependency in this
> scenario, so perhaps we'd want to use preprocessor conditionals to
> select how to implement ptr_eq based on:
>
> - architecture (allowing asm implementation overrides),
> - compiler (e.g. if compiler is clang >= version X, just do a plain
>    comparison). Likewise for gcc if it ever decides to fix this
>    behavior.
>
> I think this "hide var" hack is a fallback which can be used as a
> starting point, and then we can specialize based on architecture and
> compiler.
>
> Or do you prefer this in a different order ?

Oh, if there's some sane way to tell that the compiler already honors
address dependencies, then that should be done first and the whole
thing should just become a simple

 (a) == (b)

for that situation - allowing the compiler then the freedom to do
whatever (which can involve not using a register at all, but a compare
to memory, or whatever - the compiler might have reasons to avoid the
'cmp' and use another sequence entirely)

Then a "if we have an architecture fallback".

And then that OPTIMIZER_HIDE_VAR() thing as a last fallback.

               Linus
