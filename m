Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBC41362
	for <rcu@vger.kernel.org>; Mon,  1 Apr 2024 02:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711938492; cv=none; b=LR0SaRPc/pQw5xc9nDAM0iyYAHSZX5uV9XiJWt9Ix1RrBx7uXkrWtD8zoLTem2auFtgz38sdU0lX4XkHPLHMB1J6rTCFxuIhoJOq8NiTsNyO0zYhh9kHh+XTLWSVOJ55mNl8M7A/s5jdDAmDDo1ZSb6CcQcF+3UvM+D3k2LGbk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711938492; c=relaxed/simple;
	bh=LfhO/ttDrHhRYeW84ygSeWSEB8losPLPFBPFAJz+dqo=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=fjOPQxefTQH9lyMPVqIEDiWMDfjPe7wPCP2gCIKuTVUc6M7i73RonXX42uVEZIh/ws0wj0CKIXSDOMfw6VCBxSOmjdlgQ922S7t9S1IDERV3zW2/CK3bO+LmolvvlHBbJL+kqNTf3u7rGs+YpZ839GKWTB//QNQfm3wutsBfFT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=NGJC7Tvj; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NGJC7Tvj"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6eaf7c97738so1048909b3a.2
        for <rcu@vger.kernel.org>; Sun, 31 Mar 2024 19:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1711938490; x=1712543290; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfhO/ttDrHhRYeW84ygSeWSEB8losPLPFBPFAJz+dqo=;
        b=NGJC7TvjkbbUANZ68vwWACYvXSzt19xDrG1EtWchEK+0EY8D3h3IaJH0C/KTiu5W4l
         ihqf4CHw49NrT103cuDil55C/J8q3Oxb/npu4Hf82NIAKE2OWCqjPSHb7bDo24Xw+CT/
         JC0Tj5+IAusX1ZHMkYkGr1+pHmo/XvO/rKvZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711938490; x=1712543290;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LfhO/ttDrHhRYeW84ygSeWSEB8losPLPFBPFAJz+dqo=;
        b=A5m0x6Jk9I6UR/fOemaDdT8h1TUx8k+1wZJBwKimgzRGFd7ZUKtpd5UAFWIX7v/tUr
         WDg3K3sRfYLCz5z1gw1yUeN1LQkXUzUGCRgj+fCNx9YgyRBzZADL513/Uyr4wmUUu9gm
         HDq+HF0sj7PljuvOOXgtMdgTfMEJX74LBhjzbWbr53mU+Fi72A5tbMjxR9Zh3tv/M+Eb
         Qygv7IOyJjl/RwYdaf9AG77i3RoihBKqO4Az7NX8f0JL1xTBD4e8I5FvQn/P+HyOrwHe
         5wNbZSCmtthI5MZoDZPNJBnFBGypliJ3TfgratLwvWzgKfiD9wPeRQuASHbyJWsrMFjP
         rjOg==
X-Forwarded-Encrypted: i=1; AJvYcCXSpvkMGFLCHMsek4o0mZaf6czaAp1eOkIiwn2HSR5bZ7dl4krjd38nk16YNBuz5cA8IRrDm4stiVdJBvI6jH7dmVJU
X-Gm-Message-State: AOJu0Yy3ZP2CHd7iudGToFiO8DoD6Ja0xE+bvpxiAQr1wvCduz3ToHQ7
	lFE1XjiMRLLt3aMG/BTQ8emFAvZo8xvCHU0/FA4LTHJGQ2ecXUaNhmtxQRnstn0=
X-Google-Smtp-Source: AGHT+IEo7v0nQkkhmt17kaM/JYiwK7RoHw0U7Q9CpORk17x7Qn038TFiQedTaFsGabLvfukwIBvJPA==
X-Received: by 2002:a05:6a20:ea8:b0:1a3:a092:5746 with SMTP id fk40-20020a056a200ea800b001a3a0925746mr5387679pzb.50.1711938489912;
        Sun, 31 Mar 2024 19:28:09 -0700 (PDT)
Received: from smtpclient.apple ([103.98.78.155])
        by smtp.gmail.com with ESMTPSA id bi8-20020a170902bf0800b001e0b2851db7sm7592434plb.105.2024.03.31.19.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 19:28:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 02/10] rcu: Move rcu_preempt_depth_set() to rcupdate.h
Date: Mon, 1 Apr 2024 07:57:56 +0530
Message-Id: <B89CA77D-2E7C-4AE7-B4AA-06BF681A983A@joelfernandes.org>
References: <CAJhGHyDjoQ3TrApksYJ5o1ooU4s8rzys2UnfF6EFzGwkaSVaKA@mail.gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, x86@kernel.org,
 Lai Jiangshan <jiangshan.ljs@antgroup.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zqiang <qiang.zhang1211@gmail.com>
In-Reply-To: <CAJhGHyDjoQ3TrApksYJ5o1ooU4s8rzys2UnfF6EFzGwkaSVaKA@mail.gmail.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
X-Mailer: iPhone Mail (21D61)



> On Mar 31, 2024, at 9:46=E2=80=AFPM, Lai Jiangshan <jiangshanlai@gmail.com=
> wrote:
>=20
> =EF=BB=BFOn Sun, Mar 31, 2024 at 7:10=E2=80=AFPM Joel Fernandes <joel@joel=
fernandes.org> wrote:
>>=20
>>=20
>>=20
>>>> On Mar 28, 2024, at 1:20=E2=80=AFPM, Lai Jiangshan <jiangshanlai@gmail.=
com> wrote:
>>>=20
>>> =EF=BB=BFFrom: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>>>=20
>>> Prepare for arch-specific-defined rcu_preempt_depth_set().
>>>=20
>>> No functionality change intended, but it has to be defined as a macro
>>> as rcupdate.h is a very low level header included from areas that don't
>>> even know about the task struct "current".
>>=20
>> Sorry I did not follow changelog. If some rcupdate.h includers do not kno=
w
>> about task_struct, how does adding a macro that uses current help?
>>=20
>=20
> Hello
>=20
> This is how macro works and it expands blindly based on tokens on the
> usage-sites.
>=20
> And rcu_preempt_depth() & rcu_preempt_depth_set() are not universally
> used wrappers, the user can simply also include linux/sched.h to make
> they work.

Oh I see, so by hiding it in a macro, the code remains unexpanded. That make=
s sense..

Thanks.





>=20
> Thanks
> Lai
