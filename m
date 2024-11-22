Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FB37346F;
	Fri, 22 Nov 2024 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286170; cv=none; b=Ppyye9cUjCS9a4JDwZfts9yE/1ip0mmvAT6kK9GyqxYsFe3zIFNp7ArZKpUFRVgEpjhqzVbOD3iTCsaUfxsE+x5lmsnwfZeJolX5pNqhtknDSONgr9z2VKCgbyqJjz3PEe4oDeNKGQRShlnC7BMpN34YrMqBbuAWZyITCpXhqOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286170; c=relaxed/simple;
	bh=k0WoroNyi/hlpITMT7yy3bt5bPQ1vA9fwYVLc6J/xTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KabP7nwPRvNjwrdfy2xMTUMv81svzkubmnISE+cWHpHyg3w+i9ePjg4N1SA6OKnkqqaZbWk/V+KgjpwDoMxKoALvsd+iXDBKLCBcksOTqTe439HTRPrT86HYYryBhl69DLuaJYwqi/F0E0sD/6zcz1m+2yZH62+T2jJ2DRFrJVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=roa+NfXC; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="roa+NfXC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1732285728;
	bh=k0WoroNyi/hlpITMT7yy3bt5bPQ1vA9fwYVLc6J/xTk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=roa+NfXCg6AxaYjHlMDwuS2nYji/5ps24qS82xY5WSZd7nmOfZ/VH/6n/YZJCRy/n
	 MIPJEHDQJx6hd/Ls6CQByF/iij5YkBjaEuM8dZfUB3wxApJuWLn9h+ZjASA/j86Rgz
	 NkE3uqrg05a+Oen0G3Ojk00i1oOB4V5eEspqjyKXd0Vp8jYc5zJ5zYtvqmeRSJK0US
	 oopm2L38QHLm9saRXzibUudYda3EAcTzVD9vJMWEAtcLnaLqAtR+nTQODInapT0iOU
	 G090jT+0xRxgozAqWD+6Jz7dtPHYMNLnQAeEhKzv6toQ4l7eploP5oxmpiYsgPKTFQ
	 GYCWPHz+3gh2Q==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XvyC36RmVzHRj;
	Fri, 22 Nov 2024 09:28:47 -0500 (EST)
Message-ID: <452c869c-9ffa-4c34-834f-359b7ac6c2a8@efficios.com>
Date: Fri, 22 Nov 2024 09:28:46 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fixing Spelling Mistake in rculist_nulls.rst
To: Vyshnav Ajith <puthen1977@gmail.com>, paulmck@kernel.org,
 frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
 josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
 rostedt@goodmis.org, jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
 corbet@lwn.net
Cc: rcu@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241121232118.13507-1-puthen1977@gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241121232118.13507-1-puthen1977@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-11-21 18:21, Vyshnav Ajith wrote:
> NUll is a special marker and not maker I believe. Fixing typo with this patch.

Please fix the capitalization typo in the commit message. It should read
"Null".

Thanks,

Mathieu

> 
> Signed-off-by: Vyshnav Ajith <puthen1977@gmail.com>
> ---
>   Documentation/RCU/rculist_nulls.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
> index 21e40fcc08de..88bce14b3c37 100644
> --- a/Documentation/RCU/rculist_nulls.rst
> +++ b/Documentation/RCU/rculist_nulls.rst
> @@ -13,7 +13,7 @@ Please read the basics in listRCU.rst.
>   Using 'nulls'
>   =============
>   
> -Using special makers (called 'nulls') is a convenient way
> +Using special markers (called 'nulls') is a convenient way
>   to solve following problem.
>   
>   Without 'nulls', a typical RCU linked list managing objects which are

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

