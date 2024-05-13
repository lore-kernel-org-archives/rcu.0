Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87BF39FD9
	for <rcu@vger.kernel.org>; Mon, 13 May 2024 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715625618; cv=none; b=OaKhvFg5TiiihJGKim8u0FimmP6MhU/JIH4KJYTQAecQzPD4iXxExnZpTknHJ7z6bp9KZfdt8EeqGts0nmwbgiP0MlGTwhNaPH2/2UDygp5YC424QpeIxtQgyZRfAoOBMZzjf09/ONkLW9CbFv2Cv8dgaNmg/qvncARzGxjf4r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715625618; c=relaxed/simple;
	bh=PQZtc7Z9pTiE80kIwZK/wuYbsWEHN6gElLV+x0Ktqls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ilkKc/qNkZbzS9Macs28eE1ssYBuSKvkIr/FkPZS3HlQMYpK3VERkwnt8QuEHy+NBB2Dn/j1TCmRP9V36dIHF+T0LPyTpsplc9ZLPzcNd1Lpbl6T/PQv7z5exJLIa79w+53iIZLWW0Wkl7O+1tMIdgf6Yn9vAyoxNrIKf4HAcS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZS2kw9ZV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZS2kw9ZV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715625615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUoBqDG/F6kG6r2iSwrYwlStsdSIyfROVy8lEI7N8B0=;
	b=ZS2kw9ZVduKc7uDpZdJLlbKgmUq2eEeVT6JZKWfnRmxc/njZfCJQ2NwJF86gppssgF3+ek
	2wvu4i5lLc4+LmHuuywW3SSd87NK6/m7lU+FZMRATlc4y5uEOoDNRL7S6enGVlEkBvULOu
	RHo45EdpyoPKj2qoq7UiBsJYpsqr+vQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-MWEQ-9-xMc6jh1Pb_o2PuA-1; Mon, 13 May 2024 14:40:14 -0400
X-MC-Unique: MWEQ-9-xMc6jh1Pb_o2PuA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-43dea140e30so88701621cf.1
        for <rcu@vger.kernel.org>; Mon, 13 May 2024 11:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715625614; x=1716230414;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUoBqDG/F6kG6r2iSwrYwlStsdSIyfROVy8lEI7N8B0=;
        b=SmEieW25QoopkSBRt4Zfy+m/KURj7DTvyzwWxdOV38xSq1npR7Was1/bBmclgg++Br
         Q34IAUznRFLsViJem46eEWRyAb7fYzEyyq6gPTqdWkJs9QIRuw3+aWhmcwfpwypHp9fF
         MtUhonSqpADYtMT1tiOfOxdWbeynG6ACEg775t1K0yiIBR34dbQf9XVmr6fe0jK+EEpT
         755Ao4rwzO62Zeh+WwSm934bo0l6EuIGhXukIAHbrdArwblQYXaL+GcryMnOPtJcmPoV
         iGXQ5Ry3d+a9z1S2dIX6sH8Z5zqVris19+IJabpnrwxx31S0j1cLkA9f9QPqvVpJ4xV/
         tRpQ==
X-Gm-Message-State: AOJu0YwAmMg4/ZN7l5KSKo6cKNnTCIc74tUBchOXa6W64BH56EOwMHyb
	utBStWEpMXzVAzLNIKIJrkx+VS+PHM9+Y5rZkdCih+yrGtwp2pbPkpiw00Ok2Dk1ZXjvxbIauov
	5QK7/XqorCMZxw7+lozJIM3NiLKj5xMpNDqQKNAEjNayLiOUTrA==
X-Received: by 2002:a05:622a:190c:b0:43a:5f5e:c10b with SMTP id d75a77b69052e-43dfcdd5a23mr195223021cf.20.1715625613895;
        Mon, 13 May 2024 11:40:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYjL6bha9LtGLElcCc0Y1BnbIfuUTkyH1IJnwsoFSxr3F9xhp8kEQmBT2pPOOgbHlik0JNGg==
X-Received: by 2002:a05:622a:190c:b0:43a:5f5e:c10b with SMTP id d75a77b69052e-43dfcdd5a23mr195222681cf.20.1715625613481;
        Mon, 13 May 2024 11:40:13 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df54dda3dsm58285421cf.29.2024.05.13.11.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 11:40:12 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel
 Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 18/27] rcu: Rename rcu_dynticks_in_eqs_since() into
 rcu_watching_changed_since()
In-Reply-To: <Zjta9-jCNHmAAh6b@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-19-vschneid@redhat.com>
 <ZjoxIhtCw4Pov0VH@localhost.localdomain>
 <d3177337-51cd-4841-ba4b-8e0f8f5bbc84@paulmck-laptop>
 <Zjta9-jCNHmAAh6b@localhost.localdomain>
Date: Mon, 13 May 2024 20:40:09 +0200
Message-ID: <xhsmhttj1h7xy.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/05/24 12:59, Frederic Weisbecker wrote:
> Le Tue, May 07, 2024 at 10:14:08AM -0700, Paul E. McKenney a =C3=A9crit :
>> On Tue, May 07, 2024 at 03:48:18PM +0200, Frederic Weisbecker wrote:
>> > Indeed in practice the function only checks a change. But semantically=
 it really
>> > checks a trip to eqs because this function is only ever called after a=
 failing
>> > call to rcu_dynticks_in_eqs().
>> >
>> > So not sure about that one rename. Paul?
>>
>> As you say, Valentin is technically correct.  Me, I am having a hard
>> time getting too excited one way or the other.  ;-)
>>
>> I suggest thinking in terms of rate-bounding the change.  If you do
>> change it, don't change it again for a few years.
>
> Makes sense!
>
>>
>> Either way, should comments be changed or added?
>>
>> Of course, the scientific way to evaluate this is to whose a couple
>> dozen people the old code and a couple dozen other people the new code,
>> and see if one group or the other has statistically significantly lower
>> levels of confusion.  I don't see how this is feasible, but it is the
>> (painfully) correct way.  On the other hand, it would have the beneficial
>> side effect of getting more people exposed to Linux-kernel-RCU internals.
>> Unfortunately, it might also have the additional side effect of making
>> them (more) annoyed at RCU.  ;-)
>
> Sounds good!
>
> I divided myself in two blank RCU subjects for a double blind study
> and locked those people up overnight with a paper containing both proposa=
ls.
>
> I opened the door five minutes ago and they both elected by mutual agreem=
ent
> rcu_watching_changed_since()! Also they are thirsty.
>
> Congratulations Valentin! :-)

:-)

Now, not that I like wasting everyone's time, but... I hadn't taken a step
back to realize the calling context implied this would always be used to
check an entry into EQS, per the waiting loop structures. With this in
mind, how about the following?=20


/**
 * rcu_watching_stopped_since() - Has RCU stopped watching a given CPU since
 * the specified @snap?
 *
 * @rdp: The rcu_data corresponding to the CPU for which to check EQS.
 * @snap: rcu_watching snapshot taken when the CPU wasn't in an EQS.
 *
 * Returns true if the CPU corresponding to @rcu_data has spent some time i=
n an
 * extended quiescent state since @snap. Note that this doesn't check if it
 * /still/ is in an EQS, just that it went through one since @snap.
 *
 * This is meant to be used in a loop waiting for a CPU to go through an EQ=
S.
 */
static bool rcu_watching_stopped_since(struct rcu_data *rdp, int snap)
{
	if (WARN_ON_ONCE(rcu_watching_in_eqs(snap)))
		return true;

	return snap !=3D rcu_dynticks_snap(rdp->cpu);
}

