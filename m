Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HNUd3McG"
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2DF121
	for <rcu@vger.kernel.org>; Tue, 12 Dec 2023 12:09:42 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6d9e179b217so4326118a34.0
        for <rcu@vger.kernel.org>; Tue, 12 Dec 2023 12:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1702411782; x=1703016582; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+Xh20zqhrr/iCJFFTsT9uro5zbSBKHOa3I/xPuTFPg=;
        b=HNUd3McGI3PBXZePBJln6N7UxShskPc8zFMpV8hOI+Rfbc6TnNQOq9exgo518dAT/m
         fnhaGrrvrQCEmS+wMM1wixTObiMIaB88MqguBn3tDOtyT4yDIIOoSZRj4t0OxfRqh/Yj
         tIPGLK4uecZCNjZ64ekMpTlXsEe+anKkkA5a4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702411782; x=1703016582;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+Xh20zqhrr/iCJFFTsT9uro5zbSBKHOa3I/xPuTFPg=;
        b=ZNKhM5Gu2lsflqAex1cBZPY21+Rt8fMFujYlk1nb/wTsFI7TLw12JBe4k6s/Hpv71i
         HHhGE4gBSVE+InSxdVSWwnLj9ishILRQR9ndvUIrX+6iL9SmU/p2y+VDuj3ODI+PMXH9
         J/JUjM7SjKcUdpaBa5XTmqJljpc2uIjNZDU8kuYK9hsehk229eGzZwD4Vm7fXCDXYG8z
         180FJGL8TyNkukQekZvpFUs7VmxdTxrHhsErIzX3IprJls8i4V80QyaO8OJoLj8hTqou
         tr/p/hkzzfg7pw4r/pv4Kxh9PRTUFfuS1otfgdcyaes3bGnPK2NtPccSeWcwm0XpMasi
         fevQ==
X-Gm-Message-State: AOJu0Yytn7xlX/rFQXwO+YHp4TUq/Y+FGSCJyHmrsiiKMW8ql5V97h8a
	PD+28eWGuJsv4VMwTO1hqdQaAg==
X-Google-Smtp-Source: AGHT+IH/AADEMab3M/6qUBjdv2aKEw9zBEV7hdZDu2k87/v6BK/Pqce46L+PSMF8hGoiLLhsXpZsQA==
X-Received: by 2002:a9d:7351:0:b0:6d9:e67b:7890 with SMTP id l17-20020a9d7351000000b006d9e67b7890mr7569650otk.32.1702411782275;
        Tue, 12 Dec 2023 12:09:42 -0800 (PST)
Received: from smtpclient.apple ([185.189.25.71])
        by smtp.gmail.com with ESMTPSA id cy26-20020a056830699a00b006d9a339773csm16054otb.27.2023.12.12.12.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 12:09:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH rcu 3/5] doc: Clarify RCU Tasks reader/updater checklist
Date: Tue, 12 Dec 2023 15:09:28 -0500
Message-Id: <019C4075-EDA3-48A9-8762-CBB28D0BA37C@joelfernandes.org>
References: <20231212172653.11485-3-neeraj.iitr10@gmail.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 rostedt@goodmis.org, paulmck@kernel.org, Neeraj.Upadhyay@amd.com,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231212172653.11485-3-neeraj.iitr10@gmail.com>
To: "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
X-Mailer: iPhone Mail (20B101)



> On Dec 12, 2023, at 12:27 PM, Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.c=
om> wrote:
>=20
> =EF=BB=BFFrom: "Paul E. McKenney" <paulmck@kernel.org>
>=20
> Currently, the reader/updater compatibility rules for the three RCU
> Tasks flavors are squished together in a single paragraph, which can
> result in confusion.  This commit therefore splits them out into a list,
> clearly showing the distinction between these flavors.
>=20
> Link: https://lore.kernel.org/all/20231002211936.5948253e@gandalf.local.ho=
me/
>=20
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
> ---
> Documentation/RCU/checklist.rst | 25 ++++++++++++++++---------
> 1 file changed, 16 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist=
.rst
> index bd3c58c44bef..c432899aff22 100644
> --- a/Documentation/RCU/checklist.rst
> +++ b/Documentation/RCU/checklist.rst
> @@ -241,15 +241,22 @@ over a rather long period of time, but improvements a=
re always welcome!
>    srcu_struct.  The rules for the expedited RCU grace-period-wait
>    primitives are the same as for their non-expedited counterparts.
>=20
> -    If the updater uses call_rcu_tasks() or synchronize_rcu_tasks(),
> -    then the readers must refrain from executing voluntary
> -    context switches, that is, from blocking.  If the updater uses
> -    call_rcu_tasks_trace() or synchronize_rcu_tasks_trace(), then
> -    the corresponding readers must use rcu_read_lock_trace() and
> -    rcu_read_unlock_trace().  If an updater uses call_rcu_tasks_rude()
> -    or synchronize_rcu_tasks_rude(), then the corresponding readers
> -    must use anything that disables preemption, for example,
> -    preempt_disable() and preempt_enable().
> +    Similarly, it is necssary to correctly use the RCU Tasks flavors:

Typo: necessary.

Probably no need to resend this one, just fix in the PR.

Thanks,

 - Joel




> +
> +    a.    If the updater uses synchronize_rcu_tasks() or
> +        call_rcu_tasks(), then the readers must refrain from
> +        executing voluntary context switches, that is, from
> +        blocking.
> +
> +    b.    If the updater uses call_rcu_tasks_trace()
> +        or synchronize_rcu_tasks_trace(), then the
> +        corresponding readers must use rcu_read_lock_trace()
> +        and rcu_read_unlock_trace().
> +
> +    c.    If an updater uses call_rcu_tasks_rude() or
> +        synchronize_rcu_tasks_rude(), then the corresponding
> +        readers must use anything that disables preemption,
> +        for example, preempt_disable() and preempt_enable().
>=20
>    Mixing things up will result in confusion and broken kernels, and
>    has even resulted in an exploitable security issue.  Therefore,
> --=20
> 2.40.1
>=20
>=20
