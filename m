Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFDB1465A9;
	Fri, 27 Sep 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727453189; cv=none; b=iS/9QtHhJDSne8xcgASAtCTKnwmrTnUdpJc5IBFhY6H6FggQ4b23XGGllmfIkYvbEd5z2xyrAGw7KdeRC4WLxCXw2/RAbYfIuvBIvbX+7PrkpcVSgB0894G/HNlFBnGqGH47ZCB6CuLpmOCi8LGxA45E5o+XlfngqgVqKpcjZ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727453189; c=relaxed/simple;
	bh=LCF+qUh/MKz3OzrSjMhLzA/TwT31vZuTL8I+Ceg0rI0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LdZPqhq0RCFDER8WAXOLcUttLrWirXGNnOwrrb4m87l//l/eMqeNE9wvqtETe+bv/z9XsfT2+RlwCqsdfx/jfL3gMDLO7TP76zDJlLLMl6TCszbua6uhIxhyS8tZApVRHNdY2VkUF1FtqDc7sNkzpi+xRVMFXDW3MvcbMEQ9fOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=El7DZNNy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El7DZNNy"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b49ee353cso5610455ad.2;
        Fri, 27 Sep 2024 09:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727453187; x=1728057987; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjAiCFdlzm5VzHUYTb3sNNTZnJLLHgUJWgYzOHcrrbg=;
        b=El7DZNNyU5qo2HQpWtphoeFN87Z5okWD/6WQxdk5P6PpxAP0WvaSGTNaTeMwX6LTzT
         IegLA8eh8y9qOvxJu8/ZNbwnji69r/vaZste4ak3Zb+3Hmlsth/qfN0Wgpm/GiiXlCmC
         7fRJ1yW22CVWWjlVx3JIVThFnR9l/2tCBMrB84V9Su8G3JWG3hHgiK5FHKG9LTh4qgPh
         Ujj+fCWDaj9mriRHylQGLgmpvKl5gFEqc1P/vb1ae+7gdROIxcjmYAGJGC2W+jczbgI/
         rMWxqtSLumEwaM2UZR2UIPkGpI4LdKeXQhE4pMfQMaLI+Rn8gGX5BJ2b7V3+cI7GDF3j
         SXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727453187; x=1728057987;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjAiCFdlzm5VzHUYTb3sNNTZnJLLHgUJWgYzOHcrrbg=;
        b=wxcz9pbKiAM1+TsliCF0io4uzhruaVMRBQOMJTUZlqSpfVauwoSjqNyTuekofDbTN2
         czKlJaAcsIQf0XCqEEvFuM1eqsRzYUh/si9j4mwJaOR4UPHZ5tr/gXCLg7RFxpK3G55C
         7+vN1gvLbpfT0bxPUyvW0ioYtOkTc1y3iP9iPrR87vR+sXmPitfbBjDWvtTdCtV1Yg/f
         nuAv3XPTAhjb8rjcpEdZt15+4DatphO98BjqR1VPG4KaqdF3DAT6Gt15NG0g4/BQjOPq
         Xy08RS9dwU+68fpsUDOXLqb/QowkLocUWIcIY6IhhiJBt/C/n/2qJDr/M3FUrGpsPUNn
         2yVw==
X-Forwarded-Encrypted: i=1; AJvYcCWAJ8oxhjg3r+QsG34xqihMBy/P2G+8r19cHs3RdaBer/cLnCPUttD9yWA4i03KJJ8kS83G@vger.kernel.org, AJvYcCXeM9sWjudIVu5u+dgRmsZZj+jmAcdTHInVBLgWsumj7+GlJwc4UCAGsRAqkjr8gjcLwtabD9PuNsF7KUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzzLcyNBhsNqoEaREYvDYmUfsWWIftjnH998CtjyKcXoR4aUb/
	PjmQ/GvV0pWXLp1Al23f2MAnofWjwfN+329QWG6b7bWRRSM7VSV5
X-Google-Smtp-Source: AGHT+IF5FcC4CB2D7S/aeepZVCiS/xWqxivDP6Q5j803wcBvqAXoTyPUkjDLas9EFT7uJ1fAdDhjNQ==
X-Received: by 2002:a17:902:e743:b0:201:e7c2:bd03 with SMTP id d9443c01a7336-20b37bdc6a4mr50751985ad.60.1727453187402;
        Fri, 27 Sep 2024 09:06:27 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e5169csm15221805ad.238.2024.09.27.09.06.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2024 09:06:26 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <ZvY0gG2dCJApPbp5@boqun-archlinux>
Date: Sat, 28 Sep 2024 00:06:06 +0800
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 LKML <linux-kernel@vger.kernel.org>,
 RCU <rcu@vger.kernel.org>,
 linux-mm@kvack.org,
 lkmm@lists.linux.dev,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 rostedt <rostedt@goodmis.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kent Overstreet <kent.overstreet@gmail.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 maged.michael@gmail.com,
 Neeraj upadhyay <neeraj.upadhyay@amd.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4106601E-82BC-471D-8AD0-B5E8FE99C7CD@gmail.com>
References: <48992c9f-6c61-4716-977c-66e946adb399@efficios.com>
 <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com>
 <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com>
 <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com>
 <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
 <54487a36-f74c-46c3-aed7-fc86eaaa9ca2@huaweicloud.com>
 <CAHk-=wifOW0VEh6uL3sHSaAUA46YmPDS9Wh5HnNC2JyOiXVA=Q@mail.gmail.com>
 <ZvX12_1mK8983cXm@boqun-archlinux>
 <0b262fe5-2fc5-478d-bf66-f208723238d5@efficios.com>
 <e748893f-28a3-4b8a-a848-cfb1173ab940@app.fastmail.com>
 <ZvY0gG2dCJApPbp5@boqun-archlinux>
To: Boqun Feng <boqun.feng@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51)

2024=E5=B9=B49=E6=9C=8827=E6=97=A5 12:28=EF=BC=8CBoqun Feng =
<boqun.feng@gmail.com> wrote=EF=BC=9A
>=20
> On Fri, Sep 27, 2024 at 09:37:50AM +0800, Boqun Feng wrote:
>>=20
>>=20
>> On Fri, Sep 27, 2024, at 9:30 AM, Mathieu Desnoyers wrote:
>>> On 2024-09-27 02:01, Boqun Feng wrote:
>>>> #define ADDRESS_EQ(var, expr) \
>>>> ({ \
>>>> bool _____cmp_res =3D (unsigned long)(var) =3D=3D (unsigned =
long)(expr); \
>>>> \
>>>> OPTIMIZER_HIDE_VAR(var); \
>>>> _____cmp_res; \
>>>> })
>>>=20
>>> If the goal is to ensure gcc uses the register populated by the
>>> second, I'm afraid it does not work. AFAIU, "hiding" the dependency
>>> chain does not prevent the SSA GVN optimization from combining the
>=20
> Note it's not hiding the dependency, rather the equality,
>=20
>>> registers as being one and choosing one arbitrary source. "hiding"
>=20
> after OPTIMIZER_HIDE_VAR(var), compiler doesn't know whether 'var' is
> equal to 'expr' anymore, because OPTIMIZER_HIDE_VAR(var) uses =
"=3Dr"(var)
> to indicate the output is overwritten. So when 'var' is referred =
later,
> compiler cannot use the register for a 'expr' value or any other
> register that has the same value, because 'var' may have a different
> value from the compiler's POV.
>=20
>>> the dependency chain before or after the comparison won't help here.
>>>=20
>>> int fct_hide_var_compare(void)
>>> {
>>>     int *a, *b;
>>>=20
>>>     do {
>>>         a =3D READ_ONCE(p);
>>>         asm volatile ("" : : : "memory");
>>>         b =3D READ_ONCE(p);
>>>     } while (!ADDRESS_EQ(a, b));
>>=20
>> Note that ADDRESS_EQ() only hide first parameter, so this should be =
ADDRESS_EQ(b, a).
>>=20
>=20
> I replaced ADDRESS_EQ(a, b) with ADDRESS_EQ(b, a), and the compile
> result shows it can prevent the issue:
>=20
> gcc 14.2 x86-64:
>=20
> fct_hide_var_compare:
> .L2:
>        mov     rcx, QWORD PTR p[rip]
>        mov     rdx, QWORD PTR p[rip]
>        mov     rax, rdx
>        cmp     rcx, rdx
>        jne     .L2
>        mov     eax, DWORD PTR [rax]
>        ret
>=20
> gcc 14.2.0 ARM64:
>=20
> fct_hide_var_compare:
>        adrp    x2, p
>        add     x2, x2, :lo12:p
> .L2:
>        ldr     x3, [x2]
>        ldr     x1, [x2]
>        mov     x0, x1
>        cmp     x3, x1
>        bne     .L2
>        ldr     w0, [x0]
>        ret
>=20
> Link to godbolt:
>=20
> https://godbolt.org/z/a7jsfzjxY

Checking the assembly generated by different compilers for the kernel on =
the local machine will yield more accurate results. Some optimizations =
are restricted by the kernel. Therefore, if you use Godbolt, ensure that =
the compiler arguments match those used for the kernel.

>=20
> Regards,
> Boqun
>=20
>> Regards,
>> Boqun
>>=20
>>>     return *b;
>>> }
>>>=20
>>> gcc 14.2 x86-64:
>>>=20
>>> fct_hide_var_compare:
>>>  mov    rax,QWORD PTR [rip+0x0]        # 67 =
<fct_hide_var_compare+0x7>
>>>  mov    rdx,QWORD PTR [rip+0x0]        # 6e =
<fct_hide_var_compare+0xe>
>>>  cmp    rax,rdx
>>>  jne    60 <fct_hide_var_compare>
>>>  mov    eax,DWORD PTR [rax]
>>>  ret
>>> main:
>>>  xor    eax,eax
>>>  ret
>>>=20
>>> gcc 14.2.0 ARM64:
>>>=20
>>> fct_hide_var_compare:
>>>         adrp    x0, .LANCHOR0
>>>         add     x0, x0, :lo12:.LANCHOR0
>>> .L12:
>>>         ldr     x1, [x0]
>>>         ldr     x2, [x0]
>>>         cmp     x1, x2
>>>         bne     .L12
>>>         ldr     w0, [x1]
>>>         ret
>>> p:
>>>         .zero   8
>>>=20
>>>=20
>>> --=20
>>> Mathieu Desnoyers
>>> EfficiOS Inc.
>>> https://www.efficios.com


