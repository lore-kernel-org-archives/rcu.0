Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A7B19CC39;
	Thu, 12 Jun 2025 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749749466; cv=none; b=SYMM6NyuiEkNLOBFhJvw7Hlf532gyR97VkE/Sy0zEz33MlIuC2whfg4Q0ziiVVyd1ji/+RXPfBmI6kZtfLFywFUbyCaiwC5ib+6Q3sV7VThw0yYQLiZxKw3aLjt8mPgl5dP3h3zFB4g0w/AaDpIKpdARTTe1vhwq9y3kkzIOVkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749749466; c=relaxed/simple;
	bh=fGr0rJHgLpd6zUTWhIz+yNO88y9keApjANZl/NMnsMU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TgUFaUjbsDZXS5UPy9EuL+z4PdSBPtsYsRnnHOkyMSpMuOQCH9l6jVne8tMSMu6H4hkCF0/0iik92eDsmUK93jmycZg9ueXCKpCIA1sYtbB+B10BXqxevLm1riuQfV4/tmbgOSgAv5RfKO97CJnRUICTKm6pHi3GieEaKPQ9Iq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fixme.name; spf=pass smtp.mailfrom=fixme.name; dkim=pass (2048-bit key) header.d=fixme.name header.i=@fixme.name header.b=vdkw2Ox2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VfjoD6q9; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fixme.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fixme.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fixme.name header.i=@fixme.name header.b="vdkw2Ox2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VfjoD6q9"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id F1B871380600;
	Thu, 12 Jun 2025 13:30:59 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-01.internal (MEProxy); Thu, 12 Jun 2025 13:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fixme.name; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749749459;
	 x=1749835859; bh=WCNw8TaPoZpTkQjM0KFEMXopFWerGIynO7kJB1LPe1k=; b=
	vdkw2Ox2Yd6QBPVHDeb3ubgl6H557wDZqjWcSHZqObvs46gVd6l457ZRwCA9UN/E
	WJQoyGrx09wcebOlfRS/xAEi1Z+7bqByGMzeEZBLr1OTs3ERcnoGLtbpb+JZvuZ5
	T9ewab6rllJ7EeprPvnawlCqUL4nQHK724gLLNG7RI0Wc8OfSXVTtlxMJYo0UuAr
	7nRCEKIPk7aiDuQ+JXMe89AOauKzgeg5aKoEh95rIz4ueaUWL7Msvfqes3KErq7v
	dJn4Nk7exZvgq71w6r8pDN4WfMWoEQ1JOkHMdSEyN89Baba8q+LvmIUIf/BSIceG
	j++pOXl8IXS4F28juFisXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749749459; x=
	1749835859; bh=WCNw8TaPoZpTkQjM0KFEMXopFWerGIynO7kJB1LPe1k=; b=V
	fjoD6q9JrXO/B2ZHKoFttqERtRc27rDxR9lIx0ZalFCvQnBxVWfUCXx9TVbLmSi8
	FcsDNoWxNkRGlP2hTyP95/CmXmNet8Rv8/9XI107UBoEEVHyuC/xtJG8HNppW2AO
	M7TsW2RTaNq4rqvC9ETF8WNUkNUC+c3C+ipPcxnO20j/tQLNstU+dR2VStWZ6Efu
	8t4LgQkK57qbf17VxJvqe2JiSW7CSleuS4Dq01W1A7b5f3VNAfGP5XrvHWZp/+Br
	FxU7xX+zd6Axx7y3OHyIpOZ+Y84bymg4Y5wECdjE9j7S7Gatsv/LGNt52D0D+qf4
	up6n6yQT+Tj1L9xdhWJVw==
X-ME-Sender: <xms:0w5LaPUzdLNT5S9_T4YvGC5v0tq0B28yt3uSkgPoqU3iKnIQt_Ns0g>
    <xme:0w5LaHlZ-nKrs5paS4F9EsmDStFq5CZYibldaEB-kyfZbdwe7nxYMC1_vNArU1-gq
    ia707BtrKetx17tng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduheeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdeuohhquhhnucfhvghnghdfuceosghoqhhunhesfhhigihmvgdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeffgfdutdekieettefhjeffteeugeeluedutddt
    uddvtdetvdfhkeffgfeuieevleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthht
    ohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvvghrrghjrdhuphgrug
    hhhigrhiesrghmugdrtghomhdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtgho
    mhdprhgtphhtthhopehjohgvlhesjhhovghlfhgvrhhnrghnuggvshdrohhrghdprhgtph
    htthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhl
    mhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlrghgnhgvlhhfsehnvh
    hiughirgdrtghomhdprhgtphhtthhopeholhgvkhhsihihrdgrvhhrrghmtghhvghnkhho
    sehsohhnhidrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:0w5LaLYm50Hb1KjC4w0an2fJz8d0UD7ZlbANAVjmQefPHPzyehJ7mQ>
    <xmx:0w5LaKVr3oQvItMnMMmKq3SQEBxiZ5PaMCipglMc4-5ywtoVAfjRsg>
    <xmx:0w5LaJnXyfWMZLS9GfMDnYnsctB7nOeLb6vEx9-wxjCQheojg_IuJg>
    <xmx:0w5LaHfelu4_K6LbDJZCfyRlXyGmn8etk5w_ritaHPWJpQPj6dzc_g>
    <xmx:0w5LaCHpi6oOSIWQm53beYkI5bY8oI0FPgumVeGYj9YkRZSb_TOK0PY3>
Feedback-ID: if58145b1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 94E7A2CC0081; Thu, 12 Jun 2025 13:30:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tf837c207727b83ac
Date: Thu, 12 Jun 2025 10:30:38 -0700
From: "Boqun Feng" <boqun@fixme.name>
To: "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Joel Fernandes" <joel@joelfernandes.org>,
 "Neeraj Upadhyay" <Neeraj.Upadhyay@amd.com>
Cc: RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "Oleksiy Avramchenko" <oleksiy.avramchenko@sony.com>
Message-Id: <0caf7054-140e-4b6c-abd4-2ec2ebe79b2c@app.fastmail.com>
In-Reply-To: <4bc63cf3-29a4-4a64-be65-30f7bd55e31c@nvidia.com>
References: <20250610173450.107293-1-urezki@gmail.com>
 <4bc63cf3-29a4-4a64-be65-30f7bd55e31c@nvidia.com>
Subject: Re: [PATCH 1/3] rcu: Return early if callback is not specified
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Tue, Jun 10, 2025, at 12:33 PM, Joel Fernandes wrote:
> On 6/10/2025 1:34 PM, Uladzislau Rezki (Sony) wrote:
>> Currently the call_rcu() API does not check whether a callback
>> pointer is NULL. If NULL is passed, rcu_core() will try to invoke
>> it, resulting in NULL pointer dereference and a kernel crash.
>>=20
>> To prevent this and improve debuggability, this patch adds a check
>> for NULL and emits a kernel stack trace to help identify a faulty
>> caller.
>>=20
>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

> I will add this first one (only this one since we're discussing the ot=
hers) to a
> new rcu/fixes-for-6.16 branch, but let me know if any objections.
>

Not sure it=E2=80=99s urgent enough given the current evidence.

Regards,
Boqun

> Will push that branch out during -rc2 or -rc3 after sufficient testing.
>
> thanks,
>
>  - Joel
>
>> ---
>>  kernel/rcu/tree.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>=20
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index e8a4b720d7d2..14d4499c6fc3 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -3072,6 +3072,10 @@ __call_rcu_common(struct rcu_head *head, rcu_c=
allback_t func, bool lazy_in)
>>  	/* Misaligned rcu_head! */
>>  	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
>> =20
>> +	/* Avoid NULL dereference if callback is NULL. */
>> +	if (WARN_ON_ONCE(!func))
>> +		return;
>> +
>>  	if (debug_rcu_head_queue(head)) {
>>  		/*
>>  		 * Probable double call_rcu(), so leak the callback.
