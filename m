Received: from cloud48395.mywhc.ca (unknown [173.209.37.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BA61DA26
	for <rcu@vger.kernel.org>; Fri,  2 Aug 2024 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.209.37.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722606377; cv=none; b=B10RUT7UNDpUbp4G86UpT/syjIW6U+RAQBv5k7JRhIpWhC1TzVi4XG37o/OzSypa5/wBx8n4Wa7rZgafKYLdpuTonhq6l8aKtZU/iZBBaCpWEPE3zE9W3TPzLvijQVirITmxBFb3WcqH1TPen8VnCfUnmtc9Scd2arW+6UsBsis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722606377; c=relaxed/simple;
	bh=8EH3tfSUZ4jdK5RNKe9qyC7gcXS36vrj6lbqM90Huog=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YviGoIgEVmEaLEpxtWu1unGJjX8jv4RpsZV5owicelpB4K7LJAppKfuuoyLkhOlmNJzXut/1RP1KPXwv6jKbY+9nJW6Ay9eawA4nNlOmwC/MlBcn3WHJWKSuFoIpzCBFhX4lILA9hbO56CEW3+hJo78WS+WbQRAwnoqI3I5kJwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trillion01.com; spf=pass smtp.mailfrom=trillion01.com; arc=none smtp.client-ip=173.209.37.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trillion01.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trillion01.com
Received: from [45.44.224.220] (port=56100 helo=[192.168.1.177])
	by cloud48395.mywhc.ca with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <olivier@trillion01.com>)
	id 1sZsbb-0006ay-2x;
	Fri, 02 Aug 2024 09:46:03 -0400
Message-ID: <560ef22942010a3f0ea4ad43e0dea048fe967369.camel@trillion01.com>
Subject: Re: unexpected result with rcu_nocbs option
From: Olivier Langlois <olivier@trillion01.com>
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org
Date: Fri, 02 Aug 2024 09:46:03 -0400
In-Reply-To: <70ef45ee-2547-496a-aed3-27cec933c671@paulmck-laptop>
References: <f6d3bb877aab5ac35c3b994596354fc28c8f4f95.camel@trillion01.com>
	 <1b5bb521bc49347bf17789b50a3c4fa5e21891ad.camel@trillion01.com>
	 <df1278ca-10c6-4687-bc86-ebb0293123ab@paulmck-laptop>
	 <1684cb34f67618cff63b24da9864a23815e7f6e0.camel@trillion01.com>
	 <dbb43d66fc1642d57c71d1908dd4513dda0d55bd.camel@trillion01.com>
	 <358ab93d-7354-42cf-9498-0fc18a9d49d6@paulmck-laptop>
	 <f7b2ea1fd826c502963d574e4c229de4427440a7.camel@trillion01.com>
	 <70ef45ee-2547-496a-aed3-27cec933c671@paulmck-laptop>
Autocrypt: addr=olivier@trillion01.com; prefer-encrypt=mutual;
 keydata=mQINBFYd0ycBEAC53xedP1NExPwtBnDkVuMZgRiLmWoQQ8U7vEwt6HVGSsMRHx9smD76i
 5rO/iCT6tDIpZoyJsTOh1h2NTn6ZkoFSn9lNOJksE77/n7HNaNxiBfvZHsuNuI53CkYFix9JhzP3t
 g5nV/401re30kRfA8OPivpnj6mZhU/9RTwjbVPPb8dPlm2gFLXwGPeDITgSRs+KJ0mM37fW8EatJs
 0a8J1Nk8wBvT7ce+S2lOrxDItra9pW3ukze7LMirwvdMRC5bdlw2Lz03b5NrOUq+Wxv7szn5Xr9f/
 HdaCH7baWNAO6H/O5LbJ3zndewokEmKk+oCIcXjaH0U6QK5gJoO+3Yt5dcTo92Vm3VMxzK2NPFXgp
 La7lR9Ei0hzQ0zptyFFyftt9uV71kMHldaQaSfUTsu9dJbnS2kI/j+F2S1q6dgKi3DEm0ZRGvjsSG
 rkgPJ5T16GI1cS2iQntawdr0A1vfXiB9xZ1SMGxL/l6js9BVlIx/CBGOJ4L190QmxJlcAZ2VnQzrl
 ramRUv01xb00IPJ5TBft5IJ+SY0FnY9pIERIl6w9khwLt/oGuKNmUHmzJGYoJHYfh72Mm8RQ1R/JS
 o6v85ULBGdEC3pQq1j//OPyH3egiXIwFq6BtULH5CvsxQkSqgj1MpjwfgVJ8VbjNwqwBXHjooEORj
 vFQqWQki6By3QARAQABtDJPbGl2aWVyIExhbmdsb2lzIChNeSBrZXkpIDxvbGl2aWVyQHRyaWxsaW
 9uMDEuY29tPokCNwQTAQgAIQUCVh3TJwIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBlaka
 GGsWHEI1AD/9sbj+vnFU29WemVqB4iW+9RrHIcbXI4Jg8WaffTQ8KvVeCJ4otzgVT2nHC2A82t4PF
 0tp21Ez17CKDNilMvOt8zq6ZHx36CPjoqUVjAdozOiBDpC4qB6ZKYn+gqSENO4hqmmaOW57wT9vII
 v6mtHmnFvgpOEJl6wbs8ArHDt0BLSjc8QQfvBhoKoWs+ijQTyvFGlQl0oWxEbUkR1J3gdft9Oj9xQ
 G4OFo73WaSEK/L9IalU2ulCBC+ucSP9McoDxy1i1u8HUDrV5wBY1zafc9zVBcMNH6+ZjxwQmZXqtz
 ATzB3RbSFHAdmvxl8q6MeS2yx7Atk0CXgW9z5k2KeuZhz5rVV5A+D19SSGzW11uYXsibZx/Wjr9xB
 KHB6U7qh5sRHaQS191NPonKcsXXAziR+vxwQTP7ZKfy+g5N/e6uivoUnQrl9uvUDDPXEpwVNSoVws
 Vn4tNyrGEdN11pHDbH5fSGzdpbY8+yczUoxMmsEQe/fpVwRBZUqafRn2TVUhV0qqzsUuQcTNw1zIZ
 JgvkqrHgd4ivd2b1bXBczmu/wMGpEnF6cWzSQDiwC1NF3i+gHCuD8IX1ujThWtzXsn0VtrMkrRCbn
 ponVQ6HcbRYYXPuK0HRRjCSuAKo5porVONepiOSmu0FBrpGqBkpBtLrzKXoi1yt/7a/wGdMcVhYGg
 vA==
Organization: Trillion01 Inc
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud48395.mywhc.ca
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - trillion01.com
X-Get-Message-Sender-Via: cloud48395.mywhc.ca: authenticated_id: olivier@trillion01.com
X-Authenticated-Sender: cloud48395.mywhc.ca: olivier@trillion01.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On Thu, 2024-08-01 at 20:01 -0700, Paul E. McKenney wrote:
>=20
> Very good!!!
>=20
> The do_nocb_deferred_wakeup_timer() is due to call_rcu() being
> invoked
> in a context where it might not be safe to do a wakeup().=A0 RCU
> doesn't
> have a lot of choice in this situation, so the usual approach is to
> figure out what is invoking call_rcu() on your nohz_full CPUs and to
> make it run elsewhere.
>=20
> I don't know what is happening with mix_interrupt_randomness().
>=20
> 							Thanx, Paul
there few more that are popping out like:

tsc_sync_check_timer_fn
mce_timer_fn

but those 2 + do_nocb_deferred_wakeup_timer are not immediately
generating an interrupt. Only mix_interrupt_randomness does because it
adds an already timed out timer. So the CPU is kicked on insertion.

I have quickly looked at drivers/char/random.c

and there is no obvious way to address this that I can think of without
causing potential serious side-effects...

but I really find mysterious that only 1 of my nohz_full cpus is
impacted this...

and imho, this does not sound like a good idea to include interrupt
randomness of a nohz_full cpu...

I think that I am going to throw down the towel of reaching the goal of
100% interrupt free for now. The amount of efforts required to reach
the goal vs the diminishing result I can get is not a good deal. For
now, I am going to tolerate this 27uSec interrupt once every 2-3
seconds...

but I find this challenge very fascinating and I'll start to follow
Brendan Gregg's blog to learn more about the field.

thank you very much for your assistance. I am leaving with an
impression that the rcu dev list is very helpful and friendly!


