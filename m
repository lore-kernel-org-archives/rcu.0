Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAE74C85;
	Thu, 12 Jun 2025 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749749637; cv=none; b=XqClLYISVQYnsdMktqctsGYmDW0gXizN2op0DpQ9DxZGmEUzJeOTnUe/o2tdnt5FetU4wJIurPgO/RkE7dH57Pag9Xdbh3vN9AmfHpuUBI/lStCFx9uqboArdExyRtCbzL2k5fT8hLXxn0iLl7cuvmOsGB+cmpcnmZtwf0u+qeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749749637; c=relaxed/simple;
	bh=0q3/LubL5gGevtwml/9SziJI77apfKZE+KQe65Kvzgw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pryBeesIOFSwG/+SHo8gNyYB+mHQzC73MrZmHyGvpV1aGOYC6cC0ve/Q5Fl+PDHqEFaU426F3XvadXLKuy4Do+qW0HYwcSk4kUTjoR7wIvXxkhv4IiYae21uk5wiJTksHgMeUe0PraqsQqahaJawt6dAPFKBiv9bsY3Fu9iqJ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEjoOmgk; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEjoOmgk"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d21cecc11fso197400885a.3;
        Thu, 12 Jun 2025 10:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749749634; x=1750354434; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:references:in-reply-to:message-id
         :cc:to:from:date:mime-version:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsY9TdupTB36Z+AndagMkFfekof35rft82/pF+lI8HA=;
        b=KEjoOmgk4WVRe5p1TnNXimD6KrYS6xVKmOf0us8ULO4b62AEDL9V+VcVh2DpfDMp6z
         G/OcxMHpfTcJhkZmpVXJ+ea1xEZ/1jeXVkS8T/0YNkXY1Ja1eDIYrY3/dC89C/u8UfOb
         Nz4PupAIwgakk8IgpcXl8wz77habSjt8fyhxAPSACVCuUY/NdwoHOlC1Q6nxkEZ1dfHJ
         vC1suHNEWrGBglvhK7VszpkmFFMMsxB4fSMAool1kvu25lzDBL91PBcV2uhwJ7CXmfgX
         jhMAC2j0Qo7At4t2GtQIPLnD7CiQIyVFe0AtRDUfhAUzemyHh7zJc7oadF9vRQuhoTax
         q6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749749634; x=1750354434;
        h=content-transfer-encoding:subject:references:in-reply-to:message-id
         :cc:to:from:date:mime-version:feedback-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZsY9TdupTB36Z+AndagMkFfekof35rft82/pF+lI8HA=;
        b=N0fLCk1omd4FSEHUq6iWIBl6pLhyfWGyuyuqSSnA46rXOWaE3BCNr/vvvyyVRCzeSo
         la0MikRBEoPyTKgXyizPPZHbShvlGPZ8K14ubWkIiFPpRV1O5xh+sgns8lZQx80QUMaI
         byS2U+KKOz2qxcGFEQMNGUNv7QCWDxiB+AZYa7WVeJlRF64Axke7RS3TOlQpQame8rIE
         ZCywmMT4MwjB11SMpXpbyc9aku2QdMXZIP/zq0ncoRBoiftWtsaM9hhcoBjkgY+XD8f1
         XlI5dmiihh5vAFzF410BAfC1fgw4Xt2ts9/o1f9p3pObqomn1TPlOdYSiLopx6T6Cl82
         qRnw==
X-Forwarded-Encrypted: i=1; AJvYcCUadaUhW4VCX87g57a74ulOgixGazQljtvwgbaJgGj4SF9jet9i7s3RokksUSaolqwf814xc+zBu9atbTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh9NHO9SCy6RJF2KNqxYRpT5kgx+XinS5ky8qheCAsaR+Ng9d5
	w+EmmgDf5JuYWJsku+o7dIv2qmZDP9TTIjrmBRkKuOM0qtlqo12LuE4wigdwRw==
X-Gm-Gg: ASbGncv3lONY14lmp+LEmhggx2qoLfseco5yqg8rW61kXv+K4P/Qp191a/oL7utypU5
	fsn7NJi7bgBVOX7/J3iLFOf+JX9PAimi1glp1PuKuKG4ho5dNT6UxPKFk/90BVEA3CKlmwcyhR+
	eLOIruPUxaMFY0Msxj0c72OyjT3xCToRUdhedXFi6MPGUI7JgRe2MeehGpTpn/aGXgjLAWa7vDT
	DFL+Vp2h+Ta0nNYaD2hbws0lfAtQ9rg7FZtZlKEyAHEO0UGeRj3ZqQxGmWLd/OiD2GZ72yKWLM5
	iWMfHwY/ALQPyKEpkvEbsclArKIwRWrv+KZ/5mt5FhwXFCXYHlHn4XJ4fX93UdvozNRFvTJgFal
	e+ACDsiCx6fSRXDZf45VjqCNKMiilYA6C8PkHtNrcFlUoPYnU/l3X
X-Google-Smtp-Source: AGHT+IFw9TBuAPIAX1JpH5PeDHz8tAKFPclhg9kZ8Atjuj7sjlRGVod11v+aHAh4lgQU8+GcZ+jfNQ==
X-Received: by 2002:a05:6214:2b0e:b0:6fa:c41e:ccee with SMTP id 6a1803df08f44-6fb3462a2b3mr86144766d6.19.1749749623504;
        Thu, 12 Jun 2025 10:33:43 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c4cf21sm12320366d6.87.2025.06.12.10.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 10:33:43 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id B5A051200043;
	Thu, 12 Jun 2025 13:33:42 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-01.internal (MEProxy); Thu, 12 Jun 2025 13:33:42 -0400
X-ME-Sender: <xms:dg9LaAjVmSZaxtbT6aoIwUaK97H287xGE0LmswUj1lw9hlK-FxOBrQ>
    <xme:dg9LaJAAO0BJ1hMuCBzHZIMp1w8Mi1rzRyaiB1ebMcmPuMS4ZK9UBlUdT4jYh5Fwt
    Jj64bx9-csuaMQiCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduheeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdeuohhquhhnucfhvghnghdfuceosghoqhhunhdrfhgvnhhgsehgmh
    grihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeeileeuiefffeffiefgleehgefgueeu
    tddvjedvjeetveduffetfeffgfektdeutdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshho
    nhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngh
    eppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepledp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvvghrrghjrdhuphgrughhhigrhi
    esrghmugdrtghomhdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprhgt
    phhtthhopehjohgvlhesjhhovghlfhgvrhhnrghnuggvshdrohhrghdprhgtphhtthhope
    hfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlmhgtkhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlrghgnhgvlhhfsehnvhhiughirg
    drtghomhdprhgtphhtthhopeholhgvkhhsihihrdgrvhhrrghmtghhvghnkhhosehsohhn
    hidrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dg9LaIH1wLdBTUJCetWabLR5p9qIg4qDZH9F6Yl-6AeDsEwm0iq94g>
    <xmx:dg9LaBTaiQ-pg7kNJ0F0uegEf0lrlUIzsmTMotmAbx1RAdUrgSx0fw>
    <xmx:dg9LaNyWUxZUtK2KbgwA_iHBbs4aXH01tEl-gDeel3c5WLTdctm1lg>
    <xmx:dg9LaP5_1_Y5Xp3AfyMYCfbDAxPhP2qgcqtO3hHWZeXOHxNL1jSC9A>
    <xmx:dg9LaKxEhWsspxJKmPH7h4t05MKoaz6bwF-NSQbQ7zpKw_Q_mHH_NWDD>
Feedback-ID: iad51458e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8CF312CC0081; Thu, 12 Jun 2025 13:33:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tf837c207727b83ac
Date: Thu, 12 Jun 2025 10:33:22 -0700
From: "Boqun Feng" <boqun.feng@gmail.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Joel Fernandes" <joel@joelfernandes.org>,
 "Neeraj Upadhyay" <Neeraj.Upadhyay@amd.com>
Cc: RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "Oleksiy Avramchenko" <oleksiy.avramchenko@sony.com>
Message-Id: <e40a03bd-e817-4f4f-a5a4-d8be00cf6cc1@app.fastmail.com>
In-Reply-To: <0caf7054-140e-4b6c-abd4-2ec2ebe79b2c@app.fastmail.com>
References: <20250610173450.107293-1-urezki@gmail.com>
 <4bc63cf3-29a4-4a64-be65-30f7bd55e31c@nvidia.com>
 <0caf7054-140e-4b6c-abd4-2ec2ebe79b2c@app.fastmail.com>
Subject: Re: [PATCH 1/3] rcu: Return early if callback is not specified
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Thu, Jun 12, 2025, at 10:30 AM, Boqun Feng wrote:
> On Tue, Jun 10, 2025, at 12:33 PM, Joel Fernandes wrote:
>> On 6/10/2025 1:34 PM, Uladzislau Rezki (Sony) wrote:
>>> Currently the call_rcu() API does not check whether a callback
>>> pointer is NULL. If NULL is passed, rcu_core() will try to invoke
>>> it, resulting in NULL pointer dereference and a kernel crash.
>>>=20
>>> To prevent this and improve debuggability, this patch adds a check
>>> for NULL and emits a kernel stack trace to help identify a faulty
>>> caller.
>>>=20
>>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>
>> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
>>
>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>

(Accidentally sent from another email account, FWIW,
this is Boqun Feng and I approve this message, sorry
couldn=E2=80=99t resist :))

Regards,
Boqun

>> I will add this first one (only this one since we're discussing the o=
thers) to a
>> new rcu/fixes-for-6.16 branch, but let me know if any objections.
>>
>
> Not sure it=E2=80=99s urgent enough given the current evidence.
>
> Regards,
> Boqun
>
>> Will push that branch out during -rc2 or -rc3 after sufficient testin=
g.
>>
>> thanks,
>>
>>  - Joel
>>
>>> ---
>>>  kernel/rcu/tree.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>=20
>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>> index e8a4b720d7d2..14d4499c6fc3 100644
>>> --- a/kernel/rcu/tree.c
>>> +++ b/kernel/rcu/tree.c
>>> @@ -3072,6 +3072,10 @@ __call_rcu_common(struct rcu_head *head, rcu_=
callback_t func, bool lazy_in)
>>>  	/* Misaligned rcu_head! */
>>>  	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
>>> =20
>>> +	/* Avoid NULL dereference if callback is NULL. */
>>> +	if (WARN_ON_ONCE(!func))
>>> +		return;
>>> +
>>>  	if (debug_rcu_head_queue(head)) {
>>>  		/*
>>>  		 * Probable double call_rcu(), so leak the callback.
