Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4C48468
	for <rcu@vger.kernel.org>; Thu, 25 Jul 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918850; cv=none; b=JYPXbhjgTirle1jGqImGOXB9G9cwSh92gV4dUZSd6pFafaHJKkEQwXXlVGJFzRBJbiiWmvlERU5GrR32fc2Ip+v4d6PdTtTdqsihypNJ800RCPdzDBj12qQoecGdo2i3ggMLhHsn+19hE/HyAJ84MitW410fvN8Y5liWijdtuv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918850; c=relaxed/simple;
	bh=QnER8odTLOmeL5f+urUHq6SnfROq/GUN1kFA+FI+lYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=euSJT3IvzBD62wMDXp/ucYIZFoDpoETYQrH8BIjYgm43eKOclpHbkBdxhJbJTVY8oW8OyZq/h/w8IcQLLkL93GlgMUuC3MbRiH35E3z19IXoK2L6j7ofW8No97n07Ht/grhGsZjzrxJeNNLvX9PQ0gx4fqrlrPNyPPxlEe3zF8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUr0/ST1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUr0/ST1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721918848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXyZO9/KMzTlbY41LF3SQxG+wYDU6IMhQ0gKwsrX1JA=;
	b=CUr0/ST1itUL5gx9SBaDnZ5vEHa3yQYNxzfUfDIbtZV3A/FiPLhO6ex5gbSffR3dUYaMpk
	iWtISmIStJ3tuipsbZJvojkYZKkx8XuwZoEToS0zIenhDQcNy5gEf60UAYQOLGnRb8rxWh
	RxbkODEqafvtaOHdZae+qZy/VrHcbD4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-bWqQUntvNUm1ToKKYfS_3w-1; Thu, 25 Jul 2024 10:47:26 -0400
X-MC-Unique: bWqQUntvNUm1ToKKYfS_3w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3687f4f9fecso745157f8f.1
        for <rcu@vger.kernel.org>; Thu, 25 Jul 2024 07:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721918845; x=1722523645;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXyZO9/KMzTlbY41LF3SQxG+wYDU6IMhQ0gKwsrX1JA=;
        b=pCM7KFjgyPTACFolno5Zd0MoTsYkl0Egton3fbmCSGoTk9cuxpsz7fB4TGZSH7zL8/
         gSI88jUncoekSJADcLlh3Zx8Ngz3d7ND/RyelY1GbxALmomFOo8zK/8c470SZzgIAVTk
         qhAHtUPEWZ3s2yBf7j94nH87cTf3xTcWGipfpGxWhn8X+vmRJlHo0nxCH0LVGAm692Cx
         ucy8MZ22X85FNKGfWdWdCMWOBQq1t2j401a71+zKdQBmiCq8oYycY1DIoILFbQLUbURU
         0JXR8/ub/SRiUONxJkA5PHPJ4Cg/rLfWEVwj9fB87KHIa1MlAGMXYnPxH0gqcRQX2dk/
         JOyw==
X-Gm-Message-State: AOJu0YwBe1KHIG2B09QxHlt3F9P+FQGkN42c/OkqWA6XBYGViKS90YUw
	DcJsXX7ewgML+gfQn0wKJ5EUzX/E+oyPxejch1zfVNlAKJ5mzixx2fAXld58XlDKdqLluSubB3U
	xD331U6T9YqOU0tRbAjnmINjqVdrIY83CknNacs+pcz+3nbvihw==
X-Received: by 2002:adf:fec6:0:b0:367:9114:4693 with SMTP id ffacd0b85a97d-36b363d6995mr2433664f8f.31.1721918845616;
        Thu, 25 Jul 2024 07:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY7SCU7fqeXp6yE3DeJg2PdjZIcxm6VAqEtOFCslLYwHBG2stEnSHtd13fnU4rlruOM/8JBQ==
X-Received: by 2002:adf:fec6:0:b0:367:9114:4693 with SMTP id ffacd0b85a97d-36b363d6995mr2433651f8f.31.1721918845322;
        Thu, 25 Jul 2024 07:47:25 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fc7c3sm2427349f8f.49.2024.07.25.07.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 07:47:24 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v3 25/25] context_tracking, rcu: Rename rcu_dyntick
 trace event into rcu_watching
In-Reply-To: <ZqJHeTE52cn1-4p4@localhost.localdomain>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-26-vschneid@redhat.com>
 <ZqJHeTE52cn1-4p4@localhost.localdomain>
Date: Thu, 25 Jul 2024 16:47:24 +0200
Message-ID: <xhsmha5i5zfyb.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25/07/24 14:39, Frederic Weisbecker wrote:
> Le Wed, Jul 24, 2024 at 04:43:25PM +0200, Valentin Schneider a =C3=A9crit=
 :
>> The "rcu_dyntick" naming convention has been turned into "rcu_watching" =
for
>> all helpers now, align the trace event to that.
>>
>> To add to the confusion, the strings passed to the trace event are now
>> reversed: when RCU "starts" the dyntick / EQS state, it "stops" watching.
>>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>>  include/trace/events/rcu.h | 16 ++++++++--------
>>  kernel/context_tracking.c  | 10 +++++-----
>>  2 files changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
>> index 4066b6d51e46a..e51ef658437f0 100644
>> --- a/include/trace/events/rcu.h
>> +++ b/include/trace/events/rcu.h
>> @@ -466,40 +466,40 @@ TRACE_EVENT(rcu_stall_warning,
>>  /*
>>   * Tracepoint for dyntick-idle entry/exit events.  These take 2 strings
>>   * as argument:
>> - * polarity: "Start", "End", "StillNonIdle" for entering, exiting or st=
ill not
>> + * polarity: "Start", "End", "StillWatching" for entering, exiting or s=
till not
>>   *            being in dyntick-idle mode.
>>   * context: "USER" or "IDLE" or "IRQ".
>
> So that should be:
>
>  * polarity: "Start", "End", "StillWatching" for exiting, entering or sti=
ll not
>              being in EQS mode.
>
> Right?
>

Yep that's better, thanks!

> Other than that:
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

