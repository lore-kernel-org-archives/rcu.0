Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8027A187555;
	Sat, 28 Sep 2024 23:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727567748; cv=none; b=a4DOZISTN8LYwUeZQw6/u2zWypQ1ALIALtqyEcvsFbMKn2cJKWi01NwLHpYhMrc4QklUOWuuwYfEywuTfOT9pVWtueGjxsFRVOJ8NulEThUl06oWiK1yVllFnHrTzXPBaYJwEf4hiiyahKiK9gA+bHdUSaYHvNgMN0LdYcz2kMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727567748; c=relaxed/simple;
	bh=9e5sTY7zK4p7w1y+OWpAkSARRwSP4LSZAVAyUxRI59Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=p54FVp0AKHvwSIabtWRfuINqokTYOPV3poh2AYfuIswHBa9/Zf6MjjFtrUfdS7xIHCCYteUKi4hiHzGWLHqoPuksGg8slWaJkpPzhmB4X6FhFvD45pN7bKYJn4rQx0NFMDTp0SuLrzihSHMPLn4zODVzLJ1I0E94HMLrgOjuGzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFOvw54K; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFOvw54K"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cb37b34a87so21443606d6.0;
        Sat, 28 Sep 2024 16:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727567745; x=1728172545; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:references:in-reply-to:message-id
         :cc:to:from:date:mime-version:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdlFz25Zf+8U2eqLlBb5vpxPfbLxBGZjcVw0lkrPLz0=;
        b=NFOvw54KKMFzWVhlJWzndR/3e9SRc7hu2YrRvuivGhZhcwrmspSppAe1Mb6AShdA4h
         qSSxiQm4Za69Q9fcb/HJpTnmuwrwz3/seP+lTGAvXDg9pBWcSWakkkk2vm7MQY31LJGh
         MhOBhkjh+HfiXoPtKE+a9FeKZthsJkQ5TJiKhC4Gp8h2ogqAc46C1lb5rGOH60zA9cJi
         uQDIVJrCLhAIyZeLHdNekCzdr9PtnUYkcRROFNYJqZLTyy05iLhDOMcSVb21FiH+TVcY
         ICpT1YltxQZ/n/jbURHONvsuSrffaqEd5GA74u7KI3GuYEmX0spSqeSMkY8Mw4TiKamQ
         ZjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727567745; x=1728172545;
        h=content-transfer-encoding:subject:references:in-reply-to:message-id
         :cc:to:from:date:mime-version:feedback-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xdlFz25Zf+8U2eqLlBb5vpxPfbLxBGZjcVw0lkrPLz0=;
        b=tnyQsHJmGD3W2b035ltUQng91DmZIAzS4rxmoFmJFzcBBZC6czeztZakqiuunb4d0k
         xltTPuoX479nol1OP3kt0Nv1cX/ZkpP6IsSgQJFWHY2RIDhb1njysKBi9MhnpG0c3iLI
         /Ymc4X6BtcSku1i/wBzLeyKAu6sXIFPybzVP1+dm6N6Tx/omD6JwVr1ZMNudYgZ5NnVo
         KWTCJI7azFWFogexL5EWohU7+lWCOfzdI4PB+GppJ6Ame1SOUz8bAEfckUN+E6YoTwx1
         VNFTwu1Fj3TkNSw8cAUxoljpd9evsqfLM8rn7nbEur0BQsqQ4fzKYracADKcQ9nvd9zK
         RkhA==
X-Forwarded-Encrypted: i=1; AJvYcCUsLc5kcN2tRCU0PzgdEAyX07uKa90dyt4T92lASnDKk8SaiSmLDDeFhRSEOf5w3gitPqEYPZBNMtTv/bM=@vger.kernel.org, AJvYcCXg0BupYGHlzs8Ylq3q88IZYfoHcvFaXJQWU7qlPOwJTq/DE1IPfdWIpciONdL2HbFr9IXK@vger.kernel.org
X-Gm-Message-State: AOJu0YzcpFW/fjirDnJ+PvEINF9+aJIxpNiMewWGflgk+d4jTkzRGhL4
	2gLZWTaTXPD0d85fatzocJDYk3gOw6w1El0th6wokvnLxiC1IQZy
X-Google-Smtp-Source: AGHT+IE2EP5102rhFTu960BDjMPWsqQa3LU5oIL8pQz1/lS6aaFDHTp4mKl1437B+0bJhgqnpN7+mQ==
X-Received: by 2002:a05:6214:590a:b0:6cb:4ca3:f0ce with SMTP id 6a1803df08f44-6cb4ca3f5b9mr72919926d6.42.1727567745269;
        Sat, 28 Sep 2024 16:55:45 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b66ceb7sm24589906d6.90.2024.09.28.16.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 16:55:44 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id F1B231200068;
	Sat, 28 Sep 2024 19:55:43 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-12.internal (MEProxy); Sat, 28 Sep 2024 19:55:44 -0400
X-ME-Sender: <xms:f5f4ZocoPrQxJ5WLiMwfmz5wDlP-j5IJCAu0uWXZDVvxrvT9eQ1CAw>
    <xme:f5f4ZqOnSk1BsibM27ltQ75c7-z_AkgDZj_2_A-PeVYx0aEhXkGkaPqmaiBQNEN-1
    E-XEBQZK-LXisilrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduvddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfuehoqhhunhcuhfgvnhhgfdcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepvdeggeelleekjeejgefhuddvgfehkedt
    hffhieektedugfeiiefffeetfeejvdeinecuffhomhgrihhnpegvfhhfihgtihhoshdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegs
    ohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeige
    dqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihig
    mhgvrdhnrghmvgdpnhgspghrtghpthhtohepfedupdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehnvggvrhgrjhdruhhprgguhhihrgihsegrmhgurdgtohhmpdhrtghpthht
    ohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtohepmhgrthhhih
    gvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhmpdhrtghpthhtohepghgr
    rhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepjhhirghnghhshhgrnhhlrghise
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrghgvugdrmhhitghhrggvlhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehmjhhguhiiihhksehgmhgrihhlrdgtohhmpdhrtghpth
    htohepmhhmphhgohhurhhiuggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepqhhirghn
    ghdriihhrghnghduvdduudesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:f5f4ZpgqCtc5idgv-s_cuh42f6ea9NVvvsNFllb-IMQqrtyA5eHq6Q>
    <xmx:f5f4Zt8enAq9EWkzLskwJcdiWzcQE14D4LZYUvpZAkTFtlj1DFZjSA>
    <xmx:f5f4ZktDDdz2zUHwpUNYMyHdq-0j9xCrMyJr5xsrTTaXD21tw5cOXQ>
    <xmx:f5f4ZkGlJTAel998xJvrSlF_74NSDkJCDbtSnd5SFt8fCrOJnW0AdA>
    <xmx:f5f4ZjNUCXuMhGRTIsTR4glx6AvwJRHwYBOOImC0aETwzwehk0MZBk8Y>
Feedback-ID: iad51458e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C3CB4B00069; Sat, 28 Sep 2024 19:55:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 29 Sep 2024 07:55:23 +0800
From: "Boqun Feng" <boqun.feng@gmail.com>
To: "Alan Huang" <mmpgouride@gmail.com>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: "Alan Stern" <stern@rowland.harvard.edu>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Will Deacon" <will@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "John Stultz" <jstultz@google.com>,
 "Neeraj Upadhyay" <Neeraj.Upadhyay@amd.com>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "Joel Fernandes" <joel@joelfernandes.org>,
 "Josh Triplett" <josh@joshtriplett.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 rostedt <rostedt@goodmis.org>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, "Ingo Molnar" <mingo@redhat.com>,
 "Waiman Long" <longman@redhat.com>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Vlastimil Babka" <vbabka@suse.cz>, maged.michael@gmail.com,
 "Mateusz Guzik" <mjguzik@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 "Jonas Oberhauser" <jonas.oberhauser@huaweicloud.com>,
 RCU <rcu@vger.kernel.org>, linux-mm@kvack.org, lkmm@lists.linux.dev
Message-Id: <60123be5-ae24-4426-b9ca-6f39e64ab76b@app.fastmail.com>
In-Reply-To: <D31AF4E7-B9D5-4D2F-A4B9-1E12B5E69549@gmail.com>
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
 <20240928135128.991110-2-mathieu.desnoyers@efficios.com>
 <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
 <2091628c-2d96-4492-99d9-0f6a61b08d1d@efficios.com>
 <d2c87672-af75-4210-bd96-d7f38f2f63ac@rowland.harvard.edu>
 <d49f5d9f-559d-449b-b330-9e5a57d9b438@efficios.com>
 <D31AF4E7-B9D5-4D2F-A4B9-1E12B5E69549@gmail.com>
Subject: Re: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address dependency
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Sun, Sep 29, 2024, at 6:26 AM, Alan Huang wrote:
> 2024=E5=B9=B49=E6=9C=8828=E6=97=A5 23:55=EF=BC=8CMathieu Desnoyers <ma=
thieu.desnoyers@efficios.com> wrote=EF=BC=9A
>>=20
>> On 2024-09-28 17:49, Alan Stern wrote:
>>> On Sat, Sep 28, 2024 at 11:32:18AM -0400, Mathieu Desnoyers wrote:
>>>> On 2024-09-28 16:49, Alan Stern wrote:
>>>>> On Sat, Sep 28, 2024 at 09:51:27AM -0400, Mathieu Desnoyers wrote:
>>>>>> equality, which does not preserve address dependencies and allows=
 the
>>>>>> following misordering speculations:
>>>>>>=20
>>>>>> - If @b is a constant, the compiler can issue the loads which dep=
end
>>>>>>    on @a before loading @a.
>>>>>> - If @b is a register populated by a prior load, weakly-ordered
>>>>>>    CPUs can speculate loads which depend on @a before loading @a.
>>>>>=20
>>>>> It shouldn't matter whether @a and @b are constants, registers, or
>>>>> anything else.  All that matters is that the compiler uses the wro=
ng
>>>>> one, which allows weakly ordered CPUs to speculate loads you would=
n't
>>>>> expect it to, based on the source code alone.
>>>>=20
>>>> I only partially agree here.
>>>>=20
>>>> On weakly-ordered architectures, indeed we don't care whether the
>>>> issue is caused by the compiler reordering the code (constant)
>>>> or the CPU speculating the load (registers).
>>>>=20
>>>> However, on strongly-ordered architectures, AFAIU, only the constant
>>>> case is problematic (compiler reordering the dependent load), becau=
se
>>> I thought you were trying to prevent the compiler from using one poi=
nter
>>> instead of the other, not trying to prevent it from reordering anyth=
ing.
>>> Isn't this the point the documentation wants to get across when it s=
ays
>>> that comparing pointers can be dangerous?
>>=20
>> The motivation for introducing ptr_eq() is indeed because the
>> compiler barrier is not sufficient to prevent the compiler from
>> using one pointer instead of the other.
>
> barrier_data(&b) prevents that.
>

It prevents that because it acts as barrier() + OPTIMIZER_HIDE_VAR(b).
I don=E2=80=99t see much value of using that since we can resolve the pr=
oblem
with OPTIMIZER_HIDE_VAR() alone.

Regards,
Boqun

>>=20
>> But it turns out that ptr_eq() is also a good tool to prevent the
>> compiler from reordering loads in case where the comparison is
>> done against a constant.
>>=20
>>>> CPU speculating the loads across the control dependency is not an
>>>> issue.
>>>>=20
>>>> So am I tempted to keep examples that clearly state whether
>>>> the issue is caused by compiler reordering instructions, or by
>>>> CPU speculation.
>>> Isn't it true that on strongly ordered CPUs, a compiler barrier is
>>> sufficient to prevent the rcu_dereference() problem?  So the whole i=
dea
>>> behind ptr_eq() is that it prevents the problem on all CPUs.
>>=20
>> Correct. But given that we have ptr_eq(), it's good to show how it
>> equally prevents the compiler from reordering address-dependent loads
>> (comparison with constant) *and* prevents the compiler from using
>> one pointer rather than the other (comparison between two non-constant
>> pointers) which affects speculation on weakly-ordered CPUs.
>>=20
>>> You can make your examples as specific as you like, but the fact rem=
ains
>>> that ptr_eq() is meant to prevent situations where both:
>>> The compiler uses the wrong pointer for a load, and
>>> The CPU performs the load earlier than you want.
>>> If either one of those doesn't hold then the problem won't arise.
>>=20
>> Correct.
>>=20
>> Thanks,
>>=20
>> Mathieu
>>=20
>>=20
>> --=20
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com
>>=20
>>
