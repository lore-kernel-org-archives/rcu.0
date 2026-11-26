Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795726339;
	b=IBDaLDNH3OrMdIjKkNKh0XaBYNMUadJ3uWbQTelWbASZvJYJxuVJk4WNe/YIVDpCCkey
	 jjYMoQ7r+bz6RhvsmsQzd7A4vFklfv+hHnbRwcxSOroamlT1acnQvpmaSzkg0Ld3lCfAU
	 A2sFGNlLkhh79SPXWzSJ9g1dYErQvxdlFHcAqafAcXUagLxzuPWCPJ/wxFhhxiNgL5u3a
	 OfmeLQiFNQwpbiwweDyr5Sa0l6PJ5+achMyI/4LFNLGxpQKUimjgrCyiraR0F20OuvWFC
	 PKww0CzbsqREJiTTNEBFsyq95ko76HoXuaDpYVv3BtAEOlNx3jrZRRq80v2Q8nsYw0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795726339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=JcEEyA3sx+c6Rpqf0psrYSYbyT1hssX8f9kin0pu5oc=;
	b=xMRIhOpJC2pYQ8KYJTBIIossJlRep9SieA5YPpvH0QDPdGpd33TsdGTSKmYnJEBhCW/O
	 Z4yb2yhb558PMI1vdA8ZBr43si7KfNzkC5mXKPkuZQPlySY26kV9QCPpBAPwR1oRUmrG/
	 TrdsFGBqTokZx62R40YkNfHcdO4zgvBTWE0f6i+QLw41gctOSH/9g/9yLpg3wBJuz+YOa
	 Wa99/ESaXW93yFHtZ2zZBSpiEHFSshxbC9fS5tUwtnFRyHPsVA5cJhXeN9md43SlGJW0C
	 BmOmrs57ArgTiAoNZl3npqts8uxmUda0v5unAsVHQaZUb02vLSp0Tlwjz7lKezFZViQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sGCTtS2V;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C745606A31E
	for <rcu@vger.kernel.org>; Thu, 26 Nov 2026 20:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C745606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sGCTtS2V
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso3784277a12.3
        for <rcu@vger.kernel.org>; Thu, 26 Nov 2026 12:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795726339; x=1796331139; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JcEEyA3sx+c6Rpqf0psrYSYbyT1hssX8f9kin0pu5oc=;
        b=sGCTtS2VGoZw5jrde8R1AV7EAUVYQ1ka19rLViNoI4nBW6vy17pzFKbbefiStr/558
         uPYLarn1XZHNLmbEzxqHJ9fmvSy+AzfeiQZZxRSRFq3ZUvTwxH1OPrUnbeCKrFG3w/x3
         4CwtFAT6A3l+HcgJGHWD5fYPJrsA4+pkgvunLPlZmPGXwbLy//MJ6rHfMs4WnFdv/m4P
         cd5MdgCQsxZRqmvMOigFKhYseHN2E4mtvzF5CA/xkdk5bd+DOxlgh+b0iNmAAPvevO/5
         UL1VRFqOZEWg8gyexWkVI26T6mCaKVUhBJzcuKa+Yw64m6DT5AadgmXQh8XCi40Z/t/v
         jhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795726339; x=1796331139;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JcEEyA3sx+c6Rpqf0psrYSYbyT1hssX8f9kin0pu5oc=;
        b=cbaLjdHKkEHn9leiXekY3+26Q5vHQ9ZAGDnPZJpj8ikrAngOAMUB2eG2ee4aQLgUbL
         7jgdISOTfmD58qwavL0zbMKY8wjfzbWpTveJX9qSWiTRhrxznGdL1NYTO/8Eg3ovroMp
         ZYoolLkuASQPWBDR6YUoXxst8KmWCU3UEbP12N/fcmTWCEZA3Hlqdosd6gbDlwc2lYi6
         t4vhzjW+iUoVxS5UNHS1ZeXX45GDaJCkTLH61OdouHg7nR6q/bRRGMUOGP5ivmGFIx6s
         G8qhSq4idTONjmL/ZBKjc8xpUPElPxwH4Rvgob/YEgA+7YFvXFvd1QvN6fTdgxDOWk1e
         kO7g==
X-Forwarded-Encrypted: i=1; AL+hErF8M5GckIPitGfgEPYRQhAW4fL/Dcvn6E1c70bbrpERrVyYS6oD8PNjLwJLReNpG67XdUc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uPsZ2yVOhn/SbNnCxid9XgoeMaBNKAYAzlxQ7cuDD6yGfeJLE
	VQaRpN2SWHwGguo3EC1JX9DzVbyzmLW1NBVr/A4OD4sgR/K6RRH3R5/g
X-Gm-Gg: AZFdTZcNxFVWOv7v6itxxCzx0r9Xvwc9SVwQkRjolTGWy3RYcdBJUPZSpH/jt36x6Cg
	/M+IHTIxb9H0EduvjIJdFMrZaFFJB9rw/4sDi9uIqMhYcrae8pC65gq1YEWZAxfJYLc7ln0DL3k
	2UUOydTq+ttnyA1I52cb5TjRAaWD4jCmxSPVbJDGjjz5tTZPiz7zQc4v8UjbI5mZnbpzUAVaEjK
	WVlnh2UweAWTqPa+mph4wsPSIstA0pzmz1YTQIzipQd6r5qbfy9H9NyBTTJT6VE2skeO0nDC06M
	IgNuM69hwD0CVD8/XQWknCedx3bz32NeDPF8bgAi9BLuLodyAgyGvOHqnEOtY0kD90qVZ+mdVhp
	tmA9XU2tzxZBLq9FfTtAxPFIrer1824GNlXdiZREICeVlhb+K+eq7lmL9tcFKdgGjujknHbpFuU
	9x6X22VZA+aqp+zioNkPRxYQETH2TqNKeWA4Yyezf1+X4vWM6vXKtbKIqydsoKaf41+kLlnZLqY
	RzXiXCigWAP2YY1Emup6bDfEoghHOf2UygtOBurPo1iA4S/oRIacmmVIXnslbzsr3ln85QuDcMC
	k6pfZHyEmQPfo1NIT+7dQZEALVmdOtiN2vkRPHR2HSNK6yt1IUoQ/zOsQmKHDOFx5LUlIlbF/lq
	FFEhzYEQUKVUUA7RCgEIBmq29EEqaKL7fpA==
X-Received: by 2002:a17:90b:3d50:b0:3b4:d312:8fb4 with SMTP id 98e67ed59e1d1-3b4d31292ebmr10238160a91.43.1795726338554;
        Thu, 26 Nov 2026 12:52:18 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40f4312dfsm36006303a91.3.2026.11.26.12.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 12:52:18 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 20:52:17 +0000
Message-Id: <DN5FUYZ25YIK.1DK9UDC0VY8CZ@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kartikeya Dwivedi Kumar"
 <memxor@gmail.com>, "John Fastabend" <john.fastabend@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Bradley Morgan" <bradley.morgan@linux.dev>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Josh Triplett" <josh@joshtriplett.org>, "Boqun Feng" <boqun@kernel.org>,
 "Uladzislau Rezki" <urezki@gmail.com>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "rcu@vger.kernel.org"
 <rcu@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3] bpf: Add rcu_read_unlock_special() into btf
 id deny list
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Sechang Lim" <rhkrqnwk98@gmail.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261125055359.2715140-1-rhkrqnwk98@gmail.com>
 <E03F487E-3E0D-4FE8-9BD4-F2ABAC7213B4@nvidia.com> <awcXeA5xej8w-UL7@srsys1>
In-Reply-To: <awcXeA5xej8w-UL7@srsys1>

On Wed Nov 25, 2026 at 5:14 PM UTC, Sechang Lim wrote:
> On Wed, Nov 25, 2026 at 08:18:51AM +0000, Joel Fernandes wrote:
>>
>>
>>> On Nov 25, 2026, at 12:54=E2=80=AFAM, Sechang Lim <rhkrqnwk98@gmail.com=
> wrote:
>>>
>>> The BPF trampoline takes and drops the RCU read lock itself. When the
>>> outermost rcu_read_unlock() finds ->rcu_read_unlock_special.s set, it
>>> calls rcu_read_unlock_special(). If a fentry program is attached to
>>> rcu_read_unlock_special(), the unlock on the trampoline exit path still
>>> sees .s set and calls rcu_read_unlock_special() again, which recurses
>>> until the stack overflows:
>>>
>>>  BUG: TASK stack guard page was hit at ffffc90001657ff8
>>>  ...
>>>   bpf_trampoline_6442575622+0x5e/0xac
>>>   rcu_read_unlock_special+0x5/0x490
>>>   __rcu_read_unlock+0x9c/0x120
>>>   rcu_read_unlock_migrate+0x93/0x220
>>>   bpf_trampoline_6442575622+0x5e/0xac
>>>   rcu_read_unlock_special+0x5/0x490
>>>   ...
>>
>>Can this problem not happen also if you have an RCU read-side critical se=
ction within an ftrace probe on sensitive RCU functions?
>>
>>If yes, I wonder if we need a more general fix than BPF-specific, such as=
 using notrace on the sensitive function.
>>
>
> I don't think so. ftrace, fprobe, and kprobes take ftrace_test_recursion_=
trylock(), so
> only the bpf trampoline recurses here. v1 used notrace, and Alexei
> suggested fixing it on the bpf side instead:
> https://lore.kernel.org/rcu/20261124185659.1370644-1-rhkrqnwk98@gmail.com=
/

I don't insist. Sounds like RCU folks prefer 'notrace' ?
Then pls apply v1.

pw-bot: cr
