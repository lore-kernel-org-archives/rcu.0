Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D87314A8D;
	Thu, 11 Sep 2025 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598165; cv=none; b=ofaPS8O6STNsQdb+uMVq5uggiMk+Dv5yAWXWlopqKjUa7nSQV9KAIYphYwadjacGcj29bTW8YniD3xOpS3wUaMXT5c29z5vxajGufhA6sFxd5sFhDrJcCkKLryE4m4gA69VOf4HOV2zIYVdDX6m7ynyMTnMePtYgtvRwGN1jThk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598165; c=relaxed/simple;
	bh=KM5uuwP31S7TqCiXhLsMUVq7g4FmNtZWZpp9mmUBhNA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Rc7vgomsXRLqM4O+Imuak0gnLKrMsvRRPLUQDHTVbvOPM5g5igPZP4EKIklgx30qB8AxFb9nv9i8hlHhKL/xEGGmqQ/LC3AdsBkISrqfHhccSAwcoB7IwbeJxPqVOKGqV7cmQkp8/YM+6/AUkdqCtv/m/xco+UowhGYSOfI51tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=RwUPqhtS; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="RwUPqhtS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757598148; x=1758202948; i=markus.elfring@web.de;
	bh=KM5uuwP31S7TqCiXhLsMUVq7g4FmNtZWZpp9mmUBhNA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RwUPqhtSrCFVX/DFuK1gU4pR4GZhGSR3LdEH7sv67BWajVmS7SJF33y7NE4Yb7+L
	 qEU28mreG3XPKovxvKtKZphbd/sYJR7T3vHS1vKzec6ZaKTiumqGxGuNbVSLbRZ/3
	 MSbFPpFJUnanRAJ4o3x0zT6qwkIuTVVH8LrWTN2LAA3FHR49ehMsRJ2MgMXveQprX
	 /y9lO1A4J6DdJg1m4GNL1zifKMfGj2FAP4gBIV6EQ9I0a00GpWMzBttaffcgRYW6y
	 lss+1t/S1pdz6ymn0mfgQ7Z/0pOfI2EkdxjIPIgXkWpZx2puTcebiU8qKcXXcNsMj
	 eDavwWOMOJlTfJUsfw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.247]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqqTV-1uar9p16ht-00ebY3; Thu, 11
 Sep 2025 15:42:28 +0200
Message-ID: <d5dc1997-feea-4312-a081-229c7eacac72@web.de>
Date: Thu, 11 Sep 2025 15:42:15 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, rcu@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Frederic Weisbecker <frederic@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
References: <20250911051009.682429-1-kaushlendra.kumar@intel.com>
Subject: Re: [PATCH] rcu/segcblist: Use WRITE_ONCE() for rclp->len decrement
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250911051009.682429-1-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vv+mkD/8Wni0yKxrZSHa+/bWBYZQnwOo/ik40uep3pv265P5lmU
 wVwrjjfbZUbmI54yminP+1sK2dQ68LY12UuydLC33RCvhAOrRXlFuq4seJ+C6K5SVJdHl1P
 qzYRS9iT7LaY5sAIlsjdavJfVBhe44D7yeJwrKNc6x7+4/6oJExLs68M6v902vOgU4E41Pl
 3YGtJDq4t2s62J6U+eQew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:foRaIymvr0I=;aaV5AopOagaEtm8FXkCdcr8IoW0
 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
 H9hO5RXfN4DQBq1JaiE5nxvNOnDrIrUb8yzlt

=E2=80=A6
> This change ensures that =E2=80=A6

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17-rc5#n94

Regards,
Markus
