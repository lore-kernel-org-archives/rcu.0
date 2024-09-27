Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E8917BA4;
	Fri, 27 Sep 2024 01:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727401094; cv=none; b=UPrajuy0Wg1R1F0lG4yn7xcTLPVm1Grz05wGdRK0xwVzz5oUEAi8+jJKdfNt48FgcxQ4KFER9KUuv2KmyaKkzSz4qoJPenuxqAT1sPtIhKziVU0VoBgl4NApxf7S5avAtgPR2S2VSwN+JuIkcw7zFqkcAnMZWcUtP0/hGXm0nJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727401094; c=relaxed/simple;
	bh=EJQzkHkcMnte8kk3sy70iNjECMxGr+QWFDl5GeUDibk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NefS7jfO6rj0UR6pDaLef1zYPVKj1t4ct7X1aBku2z4wXpocRoB6sw+mwATPAu3/Nnavc6D/Qv4YGCSiiKa9kVh0MZeuMBqfJMGhAEVQ3RAa2EQZl2j0jpIifBRqFO8T4sHGQPyNBPd6TlASOJoSCRNlZ8ptj/3ytLzHN81GFFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkGlr4bp; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkGlr4bp"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a99fde9f1dso147565585a.2;
        Thu, 26 Sep 2024 18:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727401092; x=1728005892; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:references:in-reply-to:message-id
         :cc:to:from:date:mime-version:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vlhv6vJ9/p0T/1mFJKv1z0EQJeECGsYyZGl1aUOn/r8=;
        b=hkGlr4bpSNfhD2kReSeG0zZoZl1r6gYV1iV9JnBV21sSQ06Z5gb6EUAI1I5arMJANS
         i9Is3SonVigZeyXHsT5HNV8AXDAp9sNgHO3STDFmMg48jW1Vzum9hohi2X5kekvVj/cb
         CONqDmRIlPB5OJGwQTNUsnstYXUX40PJdA8s7xH1LFq9PDNwrSPW4kK4e4cRUkLOCmam
         WGPL2oWnPWexDj60+lUk2PBKRBV9DEyb2PTrgKthmniEf8ccfIHAhBtf4ruKbU7hfbCg
         XR+IIwShPgFiu7OJHVY+L7y4M6EUK+p0mzu1v7R0jyenV8UJfXO1yBcoVHA1/BVkY2ub
         AU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727401092; x=1728005892;
        h=content-transfer-encoding:subject:references:in-reply-to:message-id
         :cc:to:from:date:mime-version:feedback-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vlhv6vJ9/p0T/1mFJKv1z0EQJeECGsYyZGl1aUOn/r8=;
        b=Uub9935MNWJ/wqZpw+towh1mxy6SsXB9frcX54arcuKknXkWLIOTyf5Hhnc4gZ6C7p
         kWokYSLrzl1Lbgle+JYt5DNMuUBo8XIUq94PjPzwSUCMAuDH/pT40QBGtVPa0NayTtSY
         RoDbj1gunwJJX7Scj/Ooi7utSq7UA92f4RMSxW/THRYSE8pUfa+8W4kYHSo4Ebvv53zg
         iNHg0js/Xq9nqtzgdW2BX8h0YfwBP5o1hOnr+3OvpjdP4UZSSJSOcRGhRvypWYIOEdIH
         vyO181J3sbi7TioaK5nXryZFWjZL4RmlwJgL6Qx3boasG0LI7jgYDLAdkcRH+STIkKGo
         Ie9w==
X-Forwarded-Encrypted: i=1; AJvYcCVe3qG4FErgbtWP13M3NfNnos+Ftee5zlEX6HxLDr2mUo9w8biMmmv9k167JOMEJ50Z/YJV7ihoKK2jilo=@vger.kernel.org, AJvYcCVkNYbiBhTT4aLjeY4hpFfM4eigKbxIMLdK4H78Kh6g5qOzbli2e7joyiInxddiVyeRSi19@vger.kernel.org
X-Gm-Message-State: AOJu0YykwQTYmH9ng01syqRaBNR2C8n6+o3smNzEEAduHTIvE6Up5lZD
	33/0A/kuVACXbN9t71xF+AMb0jwqY/omMwCTroei8nCouYOXEw4O
X-Google-Smtp-Source: AGHT+IGGIx4GHXja8pTVUFJEvkYZ7hNl2HfLZkw22LyWg/l8WV2qX8Mb3nifflTKvhwohArNvVcLoQ==
X-Received: by 2002:a05:620a:408e:b0:7a3:51ed:38c0 with SMTP id af79cd13be357-7ae3775f989mr306121985a.0.1727401092281;
        Thu, 26 Sep 2024 18:38:12 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377f09bcsm42553085a.65.2024.09.26.18.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 18:38:11 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2B6821200043;
	Thu, 26 Sep 2024 21:38:11 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-12.internal (MEProxy); Thu, 26 Sep 2024 21:38:11 -0400
X-ME-Sender: <xms:gwz2Zge8sXd-s-ZSbW3Z0vmzaQ8pOcRdkcztlvUY2dFTublaKQMiJA>
    <xme:gwz2ZiN1BVbK-cXYpkB32PVwB-F1cmqlxnUIfd8wJwSHtI4hLND7qUvQU_DIYBWWP
    4TGGkLCIcZXUBi28g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtkedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfuehoqhhunhcuhfgvnhhgfdcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhephfdvkeeukedtgeeugfegudejueetjedu
    heekhffhhedvudfgveehudefudffjeelnecuffhomhgrihhnpegvfhhfihgtihhoshdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegs
    ohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeige
    dqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihig
    mhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehnvggvrhgrjhdruhhprgguhhihrgihsegrmhgurdgtohhmpdhrtghpthht
    ohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtohepmhgrthhhih
    gvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhmpdhrtghpthhtohepjhhi
    rghnghhshhgrnhhlrghisehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgvnhhtrdhovh
    gvrhhsthhrvggvthesghhmrghilhdrtghomhdprhgtphhtthhopehmrghgvggurdhmihgt
    hhgrvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepqhhirghnghdriihhrghnghduvd
    duudesghhmrghilhdrtghomhdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtgho
    mhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhg
X-ME-Proxy: <xmx:gwz2ZhiqNNXGw2cuJzQRyozcqQEm2jyzxBIeWofIkYFmkL3aNj5kNA>
    <xmx:gwz2Zl9oQfvckPeJhIm1IUsjeFbyhDhFuB-1gVcVOhRka_4yDYGWiQ>
    <xmx:gwz2ZsuOdpQCtePc-ultglAWJatgZfy2OUX7IhMioDRzZxLcDFheuQ>
    <xmx:gwz2ZsHKz-gmYYTJPLWlkPSte-POjjX5RMoS04M4eWxNsv_gFzkFoA>
    <xmx:gwz2ZrNLLIv1LcEjm3qwJZXG9vHnF8Z4baPruBahg3K_h71u9AfD0pqj>
Feedback-ID: iad51458e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DDF96B00067; Thu, 26 Sep 2024 21:38:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 27 Sep 2024 09:37:50 +0800
From: "Boqun Feng" <boqun.feng@gmail.com>
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Jonas Oberhauser" <jonas.oberhauser@huaweicloud.com>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org,
 lkmm@lists.linux.dev, "Paul E. McKenney" <paulmck@kernel.org>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joel@joelfernandes.org>,
 "Josh Triplett" <josh@joshtriplett.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>, rostedt <rostedt@goodmis.org>,
 "Lai Jiangshan" <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Will Deacon" <will@kernel.org>, "Waiman Long" <longman@redhat.com>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Kent Overstreet" <kent.overstreet@gmail.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, maged.michael@gmail.com,
 "Neeraj Upadhyay" <neeraj.upadhyay@amd.com>
Message-Id: <e748893f-28a3-4b8a-a848-cfb1173ab940@app.fastmail.com>
In-Reply-To: <0b262fe5-2fc5-478d-bf66-f208723238d5@efficios.com>
References: <4167e6f5-4ff9-4aaa-915e-c1e692ac785a@efficios.com>
 <ZvP_H_R43bXpmkMS@boqun-archlinux>
 <a87040be-890b-4e83-86bb-5018da4a894d@efficios.com>
 <48992c9f-6c61-4716-977c-66e946adb399@efficios.com>
 <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com>
 <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com>
 <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com>
 <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
 <54487a36-f74c-46c3-aed7-fc86eaaa9ca2@huaweicloud.com>
 <CAHk-=wifOW0VEh6uL3sHSaAUA46YmPDS9Wh5HnNC2JyOiXVA=Q@mail.gmail.com>
 <ZvX12_1mK8983cXm@boqun-archlinux>
 <0b262fe5-2fc5-478d-bf66-f208723238d5@efficios.com>
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard pointers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Sep 27, 2024, at 9:30 AM, Mathieu Desnoyers wrote:
> On 2024-09-27 02:01, Boqun Feng wrote:
>> 	#define ADDRESS_EQ(var, expr)							\
>> 	({										\
>> 		bool _____cmp_res = (unsigned long)(var) == (unsigned long)(expr);	\
>> 											\
>> 		OPTIMIZER_HIDE_VAR(var);						\
>> 		_____cmp_res;								\
>> 	})
>
> If the goal is to ensure gcc uses the register populated by the
> second, I'm afraid it does not work. AFAIU, "hiding" the dependency
> chain does not prevent the SSA GVN optimization from combining the
> registers as being one and choosing one arbitrary source. "hiding"
> the dependency chain before or after the comparison won't help here.
>
> int fct_hide_var_compare(void)
> {
>      int *a, *b;
>
>      do {
>          a = READ_ONCE(p);
>          asm volatile ("" : : : "memory");
>          b = READ_ONCE(p);
>      } while (!ADDRESS_EQ(a, b));

Note that ADDRESS_EQ() only hide first parameter, so this should be ADDRESS_EQ(b, a).

Regards,
Boqun

>      return *b;
> }
>
> gcc 14.2 x86-64:
>
> fct_hide_var_compare:
>   mov    rax,QWORD PTR [rip+0x0]        # 67 <fct_hide_var_compare+0x7>
>   mov    rdx,QWORD PTR [rip+0x0]        # 6e <fct_hide_var_compare+0xe>
>   cmp    rax,rdx
>   jne    60 <fct_hide_var_compare>
>   mov    eax,DWORD PTR [rax]
>   ret
> main:
>   xor    eax,eax
>   ret
>
> gcc 14.2.0 ARM64:
>
> fct_hide_var_compare:
>          adrp    x0, .LANCHOR0
>          add     x0, x0, :lo12:.LANCHOR0
> .L12:
>          ldr     x1, [x0]
>          ldr     x2, [x0]
>          cmp     x1, x2
>          bne     .L12
>          ldr     w0, [x1]
>          ret
> p:
>          .zero   8
>
>
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
