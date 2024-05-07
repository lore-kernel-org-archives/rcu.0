Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4412165FCF
	for <rcu@vger.kernel.org>; Tue,  7 May 2024 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715096901; cv=none; b=Nzv65/y4JGxJvmzFkFy4fBZk9hhuwQx4sz06lkya94UfdtSv2uu2iAtVzOzFzHLnYHMPe6pQU/TtqPb45wZDvKEcrsjgG59kc2QbQpyuoJG5pvx7rXrc21FImEVMXhWhsUTSfgIkh6WscWGp6YDrMzMVKVPVKB/IWbNHChP+UE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715096901; c=relaxed/simple;
	bh=oOOu1XAuP25uHdnqlJpmq5lHywIVMEijNpL5Bb4elI4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M9i3xzNCB5+ERj7VUdy7rUzaUulbAqI3Fv13mHJ4r/agsur1zJIlqv4FmlBBGMr18D3EgKXxiVrCktRwyq82tnmk2xgkFepARXFB9t1Dig+Tpxx8QFMK0u0ZM4urie43GeWY2nHqw0djs4GYcr6/QyyNblp+1Xk+SaAj1oDnNHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMTt6yjx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMTt6yjx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715096898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gUzbS9jvqHEpZZhO44tGoG58QukIdXWBZebz/HINvlI=;
	b=bMTt6yjxg4D/1tQ7p1dT4NJ2R90JhIkou0bFTvnDfRWB72WLp0h0DZhvDPtQCMlaUQ7Wxu
	FhijuAHpfYeoHI4UUg6P2fcXfzJild2lYe0iDE4ayamsnYkGRbyMcmTZoMpo8Z+BDCC5qM
	mdbsSUjn7gsdOtSEt6AJzbpcCDqY1ko=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-gNVzfpRJM3yxsasaU_m1jw-1; Tue, 07 May 2024 11:48:15 -0400
X-MC-Unique: gNVzfpRJM3yxsasaU_m1jw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34e0d47c9b7so2589408f8f.0
        for <rcu@vger.kernel.org>; Tue, 07 May 2024 08:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715096894; x=1715701694;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUzbS9jvqHEpZZhO44tGoG58QukIdXWBZebz/HINvlI=;
        b=Y2ahs1oT2E/dU066jTsNhg2u/LNKRkHwfZhVF4eck4aeonnUkuRaNw5Ab3xUdO557T
         I8iAEyC/WZBO+0wqdJf8bPczK9SC77FVTEXPoka4yAgjzWZbtHoS+7Oxs39kPTFtg6tO
         YzkpP0kLmBH3iDVbjIbI6tZEBgr5GSMMzIt5rH2Gkokfpyy9tQJw9NxMdOOGtMAeAgMk
         RMh89540S25XSLCgpJgTOqAO6irXiizlqcG1UfYDQEpPtJsRfN6wPeTNfLQvPho2+3Ui
         SaRRlYQY+YHzZzC5LOlFmF8PE9ozljE9OcRWb31IWxugdmOboMKw63wtSOD3RWPHlkW8
         nmFA==
X-Gm-Message-State: AOJu0YycPeMNpCyqVu2lMjBBVl8Ok7hkRDDxSl3xccmakUH37CJ/2Y87
	inIx5+yn4l4Eb74hfT1/1HNPsulHvHCVCvosZ7NtDtd4F4sFGXX/ALDgmKWiha+rQDG1cc8UMa1
	1302mgmzWQSmXzojpONPwjR4skwFUyA4CBf++s9d2DZorzD80yw==
X-Received: by 2002:a5d:4145:0:b0:34d:ce05:29ef with SMTP id ffacd0b85a97d-34f81a551bamr2673954f8f.17.1715096894241;
        Tue, 07 May 2024 08:48:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsJkYVdzE27qN7T4Du3UQ6hbz02FVZWi3pzAmMmwPsZNqOXYDxIUbX8l1lhu7fnfUQfIKn4A==
X-Received: by 2002:a5d:4145:0:b0:34d:ce05:29ef with SMTP id ffacd0b85a97d-34f81a551bamr2673925f8f.17.1715096893855;
        Tue, 07 May 2024 08:48:13 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id y17-20020a5d4ad1000000b0034cfa17d74dsm13166305wrs.104.2024.05.07.08.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 08:48:13 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 17/27] rcu: Rename rcu_dynticks_in_eqs() into
 rcu_watching_in_eqs()
In-Reply-To: <ZjotdJwp3RXkrA7S@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-18-vschneid@redhat.com>
 <ZjotdJwp3RXkrA7S@localhost.localdomain>
Date: Tue, 07 May 2024 17:48:12 +0200
Message-ID: <xhsmh34qtipxf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/05/24 15:32, Frederic Weisbecker wrote:
> Le Tue, Apr 30, 2024 at 11:17:21AM +0200, Valentin Schneider a =C3=A9crit=
 :
>> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
>> RCU_WATCHING, reflect that change in the related helpers.
>>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>>  kernel/rcu/tree.c       | 8 ++++----
>>  kernel/rcu/tree_exp.h   | 2 +-
>>  kernel/rcu/tree_stall.h | 2 +-
>>  3 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index 857c2565efeac..d772755ccd564 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -308,9 +308,9 @@ static int rcu_watching_snap(int cpu)
>>
>>  /*
>>   * Return true if the snapshot returned from rcu_watching_snap()
>> - * indicates that RCU is in an extended quiescent state.
>> + * indicates that RCU in an extended quiescent state (not watching).
>
> *is in
>

Oh, thanks!

>>   */
>> -static bool rcu_dynticks_in_eqs(int snap)
>> +static bool rcu_watching_in_eqs(int snap)
>
> I would be tempted to propose rcu_watching_snap_in_eqs() but the
> purpose is not to dissuade people from intoning RCU code after all.
>

I've struggled with finding something sensible for the snapshot helpers; I
think I prefer your suggestion, that way we can have a common prefix for
all snapshot-related helpers. Also I keep reading rcu_watching_in_eqs() as
"is RCU watching while being in EQS?" which is nonsense.

> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

