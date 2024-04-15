Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6F3823CE
	for <rcu@vger.kernel.org>; Mon, 15 Apr 2024 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198999; cv=none; b=Y9pFSwPfHRJduJ/L63F+RHbVgd4qCUAJwOiEoSSE2L0HJOyZaiT7piUxsffXvuXybxTPSK4poOB8aR8WRP3EhPoYrCKqz0jIwaUfJjL29B1CmEc4Rcgq5ljwCNduQd8pJJYf6IZxe4UtdiZj1hDRRZqugRKX3Bqn2Ilh5QTcheQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198999; c=relaxed/simple;
	bh=+QqbqSu1MMoSgiWlfiQTfvZcvD2ji/HRaDBIniV7kB0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nj2voZ3+1DsWQhggDX6Hxb9ADqgMunewhOYbTCrqlyj0Iivf32MK+O+Ns1CfpY/mZ7Qh6fLFgoBJlwN7A3NGeIg5udjpfOxLNxBJOECIovpwUg6xLA07QAu7O7XiqVUCgwA9KPb2xYtzSf3YEzFWD8RKMmjnyg8OfkqqsXrtOYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bGHlrHTq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGHlrHTq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713198996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atGkGHaiCSKARFp5t+MBXqAkwdjlgEs5Nciu/JvDSO4=;
	b=bGHlrHTqWmHoDkCkvZwDY8xesQ75k9VxIxh84xcWTjVEhHLTN7okKvlAa2Xk48nH213NAF
	TQXmw4ocKfd34GeOqLXuhrPLsAuLC0cT/kNmbO0Ciem8qylijfdoGodI0adt9QKsZQ0DUR
	nH9ijTZhBaa3xfx06kSNv+VmAO4gmAM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-cg4wr9kJP9mj_bM9KafNmA-1; Mon, 15 Apr 2024 12:36:35 -0400
X-MC-Unique: cg4wr9kJP9mj_bM9KafNmA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d8a1f8c17fso32957571fa.3
        for <rcu@vger.kernel.org>; Mon, 15 Apr 2024 09:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198993; x=1713803793;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atGkGHaiCSKARFp5t+MBXqAkwdjlgEs5Nciu/JvDSO4=;
        b=Q7zg8aJKXUAUJEPuOeSXDCgveMyDfcAnrSZUXpYuLAGxoSrdquibeSnHkLJvzjucJ/
         60V5uXMwqod6ztLyWNL8WsYg/EmLOT0XRsd9A3irKkwMZ1KH+spxf6PO2ebB3tQ6ul66
         IgoLcqarU4TFXCq23V/S/4Blu+B+Y+8XcgvdbUbOkSqv4ng/p5VWmGXhBPxla9w5e1vg
         ATRXOO1RvF57JRIh8NAOSzHvdyXi+AHqZ8qLP01rUkUjXjek5UMMXsczGwHOGeDb/bxX
         ydcpzV8GboLRwIqMocQFOqCE57U76oeTQh/cDBmZFc5Ho4x+Hn+lvYXuJIOJkeRn8Dcr
         Zcgg==
X-Gm-Message-State: AOJu0YzfaS+6DzFXVK33kynXB754GvAhHZwAMEslzn4vaZ/xMClMm3m+
	lzMq5lkidcL/ENtRwqoyVXM2BdQM+S0t8G8nt1S6Htphj0PaAaq5gbmSXgHBKmH0XNf2CZhvwf7
	/GDKxXHCnIOjc6Rnzbwf9NAxgvwaVFtijK6cvMLWPiqGc7SIVVw==
X-Received: by 2002:a2e:9e96:0:b0:2d8:64c9:8d39 with SMTP id f22-20020a2e9e96000000b002d864c98d39mr8110594ljk.37.1713198993683;
        Mon, 15 Apr 2024 09:36:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyogDqJzKINArWAzh/dqhb2mlcc0D4Erk9dK0QoHKBU5jHaWEgiddtk2hMVtWNwF1AF8LfNg==
X-Received: by 2002:a2e:9e96:0:b0:2d8:64c9:8d39 with SMTP id f22-20020a2e9e96000000b002d864c98d39mr8110575ljk.37.1713198993322;
        Mon, 15 Apr 2024 09:36:33 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id bm15-20020a170906c04f00b00a46d9966ff8sm5774503ejb.147.2024.04.15.09.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:36:32 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: paulmck@kernel.org, Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel
 Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH 2/2] context_tracking, rcu: Rename RCU_DYNTICKS_IDX to
 CT_DYNTICKS_IDX
In-Reply-To: <af3eed7e-a889-4008-ba47-045483ab79fc@paulmck-laptop>
References: <20240327112902.1184822-1-vschneid@redhat.com>
 <20240327112902.1184822-3-vschneid@redhat.com>
 <Zg6tYD-9AFPkOOsW@localhost.localdomain>
 <1ef9d1f9-16a2-4ddc-abd5-6c3b7cde290f@paulmck-laptop>
 <ZhZqX0YqlzPoOK2b@localhost.localdomain>
 <af3eed7e-a889-4008-ba47-045483ab79fc@paulmck-laptop>
Date: Mon, 15 Apr 2024 18:36:31 +0200
Message-ID: <xhsmhjzky8tww.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/04/24 12:19, Paul E. McKenney wrote:
> On Wed, Apr 10, 2024 at 12:30:55PM +0200, Frederic Weisbecker wrote:
>> Le Tue, Apr 09, 2024 at 12:53:03PM -0700, Paul E. McKenney a =C3=A9crit :
>> > I am having a hard time getting too excited about the name.  I could
>> > suggest CT_RCU_WATCHING_IDX, but that isn't exactly the shortest
>> > possible name.
>>
>> I really like CT_RCU_WATCHING. It says everything. The _IDX isn't even
>> needed after all. What do you think?
>
> Works for me!
>

Sounds good to me too, thanks for the suggestion :)

Now, what about ct_dynticks() & friends? I was about to do:

-static __always_inline int ct_dynticks(void)
+static __always_inline int ct_rcu_watching(void)
 {
-	return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_DYNTICKS_M=
ASK;
+	return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_RCU_WATCHI=
NG_MASK;
 }

... but then realised that there's more siblings to the rcu_dynticks*()
family;

AFAICT dynticks_nesting could also get the rcu_watching prefix treatment,
`rcu_dynticks_task_exit() -> rcu_watching_task_exit` doesn't sound as
obvious though. The rcu_dyntick event probably can't be renamed either.

I'm not sure how far to take the renaming; seeing things like:

  notrace bool rcu_is_watching(void)
  {
          bool ret;

          preempt_disable_notrace();
          ret =3D !rcu_dynticks_curr_cpu_in_eqs();
          preempt_enable_notrace();
          return ret;
  }
  EXPORT_SYMBOL_GPL(rcu_is_watching);

makes me think most of the rcu_*dynticks / rcu_*eqs stuff could get an
rcu_watching facelift?

Here are my current considerations for identifiers used in context_tracking
in decreasing order of confidence:

| Old                                   | New                              =
                             |
|---------------------------------------+----------------------------------=
-----------------------------|
| RCU_DYNTICKS_IDX                      | CT_RCU_WATCHING                  =
                             |
| RCU_DYNTICKS_MASK                     | CT_RCU_WATCHING_MASK             =
                             |
| context_tracking.dynticks_nesting     | context_tracking.rcu_watching_nes=
ting                         |
| context_tracking.dynticks_nmi_nesting | context_tracking.rcu_watching_nmi=
_nesting [bit of a mouthful] |
| rcu_dynticks_curr_cpu_in_eqs()        | rcu_watching_curr_cpu() [with an =
added negation]              |
|---------------------------------------+----------------------------------=
-----------------------------|
| TRACE_EVENT_RCU(rcu_dyntick,          | [Can't change?]                  =
                             |
|---------------------------------------+----------------------------------=
-----------------------------|
| rcu_dynticks_task_enter()             | rcu_watching_task_enter()        =
                             |
| rcu_dynticks_task_exit()              | rcu_watching_task_exit()         =
                             |
| rcu_dynticks_task_trace_enter()       | rcu_watching_task_trace_enter()  =
                             |
| rcu_dynticks_task_trace_exit()        | rcu_watching_task_trace_exit()   =
                             |

Thoughts?

