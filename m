Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58982D027F
	for <rcu@vger.kernel.org>; Thu, 13 Nov 2025 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044249; cv=none; b=tmAvyP7vWF9lNpAp1xFIzWN+TBRxYtF03Wve9MUylXAhnhAgdEtNngB8bwEBS790jTTS8s70lDMzsZE7sEj4JK8HI/kPITzX7EhEXw3pCqqxIaEFOqCdLP+ET6W3tWcLYHEzBFEJES77+7p209aifi0ibTV9FhrPmEKsMv0XSUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044249; c=relaxed/simple;
	bh=MBXryWsSo8WBJYsfFQQsezl+bvHfvcNsNG0PI/C7tiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuctVAb4qK6m4/ApuYruYgTVXSJl/APaJQk955HUv/5yHfLdVf5F+PIzqbRhRC9Qkr38rr+5Ede69ocHMd4tCN/00J8XJ6ZDHOPspTTuDN65ZibASIbEoNjT/T2GXbk8idDxWJnECAVNcInlTr4TFHNT8pE9S1kIzSmAAn+FZuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nEke/2FF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEke/2FF"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7af6a6f20easo848222b3a.0
        for <rcu@vger.kernel.org>; Thu, 13 Nov 2025 06:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763044245; x=1763649045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MBXryWsSo8WBJYsfFQQsezl+bvHfvcNsNG0PI/C7tiU=;
        b=nEke/2FFZG1ng+mTf7XuFWr72uIT/zMOwz5Plept3fLottY4A7mR9yd0pdYTXPfV3L
         hK19/tFNKtBWt03/3aIrLuEFubAZ86OG8UKxWfMXZ/xwaPm0haeaSFvRKRZyqL68IFFr
         RUbfkpw/AxbmwRe4UBjcf4u0hY4RgCtAQU+DeP++bLkWGUge3WghXIIG2aYlBAHwJrwa
         qNbtn/U/W2g+PNsPotzSGxq1CDZ2ivBjEr/ylIi5pnAtig/o0c8DLddUOMVoTVfBVYw2
         2Wrg941g53UdcpQMWmmNwsTkD97k9PkGsnanMcPBhYlfeFftgOS6jQNCW+h68bt/aUbO
         AUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763044245; x=1763649045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBXryWsSo8WBJYsfFQQsezl+bvHfvcNsNG0PI/C7tiU=;
        b=l8hkZ8zETvvlE3I+XXulq2ndT/pq9uGlHf0Q3Qq2mJ8rcehg+7jnv1cIqXe5Dd0wzV
         PuzSLDCmsNucdlOQZD3bBi3/s9NS/nQRuYTE2031nL8Leh/Lyha4r5hfHmXwneWgU1+Q
         A2DmIht+piHo5aakeRszEriKgxcOI4Z0D9j/5b1JFQxe87lOPafYZeRRFykaM2dkdV4g
         HhYKSctGgfEBQ3WP7WZT+emM3BE1DR3j35LMaJSIPF2g8b/NeAr7P1vEI7faxAgqaBEB
         7tobBf0+onCJ/XVUPY9kvIKo9YW/ZVjgFAcEIww/x0vzc+5uC1Vk2kaO86/MUbi2jKJx
         8FYw==
X-Forwarded-Encrypted: i=1; AJvYcCVAbFx2jSlzxlF8zBEzreqFMtdzlpgdofbv47LnUjjQuDYf/HVmcgXXAzHVmoCJe75cWPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXmYkZOBizxbPB71aQ1GG850Xt/MyaxRT1mb0TUSq4mUIDE2x1
	pNP+h801tcDKwzcHQqJfDVUN4fKsWLI4T5DefyeNduuenmhaCOjtzgp8/05DRg/umE5QfHF/hiI
	us4kgBhfv+WyoFOwZKQTG78UUushrBoDwSEyl7dco
X-Gm-Gg: ASbGncuqElmgzyxYiZGvSqN/nnsIDnmpDINeO03bv81RFkQlwUhd9KABMvybO/KV1IE
	LCzto9k3SiJ1DYABziRVjzHBdrP+IAC9sX3Pwi24om4uMHI6hLwW4duA3Sw64hlJkBukI3z7eWQ
	5x5QqICabXKlLR+CVM5YEaqr/OH9pv0iMYFhII5RFnKlQBAbA/MBbTFJkT0kn0g3eKGdhjV2uaO
	xcRWKVVasj5K5aK4nmt3x1raZ+uyPB2WVJzQGfNebLYy3GR0wEjATOMoYPrJ+EIOynEvG4w6kYO
	s4i7zwQdS8kkOF93AZJHva8=
X-Google-Smtp-Source: AGHT+IFnNFIlMm9/L/bcyHMVah+51vkdm0T/jdjxqhLQ7LFy8/zaHzLzvotK4qxuC0MECLmidBODybpZNRr9UFx4Cuk=
X-Received: by 2002:a17:903:fa7:b0:294:f6b4:9a42 with SMTP id
 d9443c01a7336-2984ed2b5edmr67173465ad.9.1763044244630; Thu, 13 Nov 2025
 06:30:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918140451.1289454-1-elver@google.com> <CAHk-=wgd-Wcp0GpYaQnU7S9ci+FvFmaNw1gm75mzf0ZWdNLxvw@mail.gmail.com>
 <aMx4-B_WAtX2aiKx@elver.google.com> <CAHk-=wgQO7c0zc8_VwaVSzG3fEVFFcjWzVBKM4jYjv8UiD2dkg@mail.gmail.com>
 <aM0eAk12fWsr9ZnV@elver.google.com>
In-Reply-To: <aM0eAk12fWsr9ZnV@elver.google.com>
From: Marco Elver <elver@google.com>
Date: Thu, 13 Nov 2025 15:30:08 +0100
X-Gm-Features: AWmQ_bmFh2aVYHZwkaHdVYkb7IeD9B_c5E9TrUEhRxSr8kO14B_rxSCEK8GKI2o
Message-ID: <CANpmjNNoKiFEW2VfGM7rdak7O8__U3S+Esub9yM=9Tq=02d_ag@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Compiler-Based Capability- and Locking-Analysis
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
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
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Sept 2025 at 11:10, Marco Elver <elver@google.com> wrote:
[..]
> I went with "context guard" to refer to the objects themselves, as that
> doesn't look too odd. It does match the concept of "guard" in
> <linux/cleanup.h>.
>
> See second attempt below.
[..]

I finally got around baking this into a renamed series, that now calls
it "Context Analysis" - here's a preview:
https://git.kernel.org/pub/scm/linux/kernel/git/melver/linux.git/log/?h=ctx-analysis/dev

As for when we should give this v4 another try: I'm 50/50 on sending
this now vs. waiting for final Clang 22 to be released (~March 2026).

Preferences?
