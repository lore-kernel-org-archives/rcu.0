Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967151DF72F;
	Thu,  7 Nov 2024 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975654; cv=none; b=HJ0jVQVDdINYqveDy/bYW/oKFQoSpf7wUhpFD1GsJdnCjdFj7cXdulqFaYsj4m2NhqNcwY96pk4/wvzjsVKJeVY8puLgF7O9tNmi1gs1qCU1xMQEwwLnvy6AV2RkP9liE9OdML9yTy3IoZQFOfAHqVLcl+p7zidgH3R/uzn4eTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975654; c=relaxed/simple;
	bh=Opi7PAEFaG+9SFGD2InUqdDcvGdzNbi6zSEJ/4Yro1c=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qcvJO3QOaShBK1rBtbL2VRPovEPelirmCM69nI9U9QRpNRBMLhj2R+MHqIhfAWXtv81s7yfRilUIgj2VSa48jPv5OplMAJD0jPOW6AH9GWC3nd9OpynCm+a9I7WIwZ4/RXoB6yJtmnHZnkjEdd/sPWdlYMpQqp1zalsSHqiAmBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=j3/FQfCR; arc=none smtp.client-ip=159.100.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="j3/FQfCR"
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.100])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id C8F5B26761;
	Thu,  7 Nov 2024 10:34:04 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id 3882E3E9D6;
	Thu,  7 Nov 2024 10:33:57 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 3F88240078;
	Thu,  7 Nov 2024 10:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1730975636; bh=Opi7PAEFaG+9SFGD2InUqdDcvGdzNbi6zSEJ/4Yro1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j3/FQfCRb3jGhtZs+Jg/4sYOxXp/LBNLYVl7Q/o63HFNAKBR8Fx/Aq2nF/x4Y19BT
	 FNnWOZRivnmkhCkISxGQVHLGD/ZaIGxKIgRhDAJBKYbGuOtrcH4g5kmOSoUrkr9wUo
	 LOT7uPUu3KeacqZ4J8/XPhGYj+v6VeKgGpYQuY9g=
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 9B5CA40490;
	Thu,  7 Nov 2024 10:33:55 +0000 (UTC)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 07 Nov 2024 18:33:55 +0800
From: Mingcong Bai <jeffbai@aosc.io>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, Linux regressions mailing
 list <regressions@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
 sakiiily@aosc.io
Subject: Re: [Regression] wifi problems since tg3 started throwing rcu stall
 warnings
In-Reply-To: <ZyyQuTfMMSLwStf_@pavilion.home>
References: <b8da4aec-4cca-4eb0-ba87-5f8641aa2ca9@leemhuis.info>
 <ZxjLQzHKuR-w16hF@pavilion.home>
 <2b25a988-6965-48e4-a788-58dd8a776e06@leemhuis.info>
 <e2ffd3d06fad236ea900d4fb439b2240@aosc.io>
 <937c258b-f34c-4f63-949d-a5e7c8db714d@leemhuis.info>
 <ZyyQuTfMMSLwStf_@pavilion.home>
Message-ID: <eee3b235c14a84289b2fe1a40c542363@aosc.io>
X-Sender: jeffbai@aosc.io
Organization: Anthon Open Source Community
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.10 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	MISSING_XM_UA(0.00)[]
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3F88240078

Hi all,

在 2024-11-07 18:04，Frederic Weisbecker 写道：
> Le Thu, Nov 07, 2024 at 10:10:37AM +0100, Thorsten Leemhuis a écrit :
>> On 05.11.24 08:17, Mingcong Bai wrote:
>> > (CC-ing the laptop's owner so that she might help with further testing...)
>> > 在 2024-10-23 18:22，Linux regression tracking (Thorsten Leemhuis) 写道：
>> >> On 23.10.24 12:09, Frederic Weisbecker wrote:
>> >>> Le Wed, Oct 23, 2024 at 10:27:18AM +0200, Linux regression tracking
>> >>> (Thorsten Leemhuis) a écrit :
>> >>>>
>> >>>> Frederic, I noticed a report about a regression in bugzilla.kernel.org
>> >>>> that appears to be caused by the following change of yours:
>> >>>> 55d4669ef1b768 ("rcu: Fix rcu_barrier() VS post CPUHP_TEARDOWN_CPU
>> >>>> invocation")
>> >>> Are you sure about the commit? Below it says:
>> >> Not totally, but...
>> >>
>> >>>> As many (most?) kernel developers don't keep an eye on the bug tracker,
>> >>>> I decided to write this mail. To quote from
>> >>>> https://bugzilla.kernel.org/show_bug.cgi?id=219390:
>> >>>>
>> >>>>>  Mingcong Bai 2024-10-15 13:32:35 UTC
>> >>>>> Since aa162aa4aa383a0a714b1c36e8fcc77612ddd1a2 between v6.10.4 and
>> >>> Now that's aa162aa4aa383a0a714b1c36e8fcc77612ddd1a2 which I can't
>> >>> find in vanilla
>> >>> tree.
>> >> ...quite, as that is the commit-id of the backport to v6.10.5; and the
>> >> reporter reverted it there. Ideally of course that would have happened
>> >> on recent mainline. If you doubt, ask Mingcong Bai to check if a revert
>> >> there helps, too.
>> > Do we need any further information/testing on this issue? Please let me
>> > know if there's anything we can do as the issue still persists in 6.12.
>> 
>> Hmm, no reply from Frederic. Not sure why, maybe he is just away from
>> the keyboard for a few days. But if the reporter has a minute, it 
>> might
>> be wise to check if reverting that commit on top of 6.12-rc6 or newer
>> also fixes the problem, to rule out any interference from changes
>> specific to the stable series.
>> 
>> Ciao, Thorsten
> 
> Sorry for the lag, I still don't understand how this specific commit
> can produce this issue. Can you please retry with and without this 
> commit
> reverted?
> 
> Thanks.

Yes, we are on it. Should report back in six hours or so.

Best Regards,
Mingcong Bai
