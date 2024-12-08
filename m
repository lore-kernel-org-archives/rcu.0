Received: from smtp-4.orcon.net.nz (smtp-4.orcon.net.nz [60.234.4.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8571E86E;
	Sun,  8 Dec 2024 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.234.4.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733701148; cv=none; b=Rg5dZMb8ih+/YhJtbqw/Kh7onBpkjQaz2En4z/0sEoZ+ZcNMJVIIsZsIRBZ52NRif0XjjeX9s7ZxAu5KMFVrO83KawXFE15Cjy7N/H2vdW7w6SS10dEqRIQYcJvAqX7vuVBEV3D227mOgUp6vC2q2anpF9H7iOt5o9tv5D6j37I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733701148; c=relaxed/simple;
	bh=JFMTOKpBJZ3SNbmQWtMysYh/8i8pQs+b7Egfm3R+MUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HebrsqbLNaYF1T/HEBML71e8WMEEt8NLq5Uf0YOtcVuKtrQgbmvYD7VWVUcYppYyNJQ0UnerCk8WV5KlQI5oZvZpjimRiipPAu6X+m/iPdmyuP6g/L+EqW6MNjbM0SBPJb2Lj8FxwQg2iN1LkL1sKUsP6pRah/+dY9Cb+j028nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orcon.net.nz; spf=pass smtp.mailfrom=orcon.net.nz; arc=none smtp.client-ip=60.234.4.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orcon.net.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orcon.net.nz
Received: from [121.99.247.178] (port=40664 helo=creeky)
	by smtp-4.orcon.net.nz with esmtpa (Exim 4.90_1)
	(envelope-from <mcree@orcon.net.nz>)
	id 1tKQXN-0007sD-7A; Mon, 09 Dec 2024 12:18:05 +1300
Date: Mon, 9 Dec 2024 12:18:00 +1300
From: Michael Cree <mcree@orcon.net.nz>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	paulmck@kernel.org, rcu@vger.kernel.org,
	linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
Message-ID: <Z1YpKFQGtMWF3yy3@creeky>
Mail-Followup-To: Michael Cree <mcree@orcon.net.nz>,
	Magnus Lindholm <linmag7@gmail.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	paulmck@kernel.org, rcu@vger.kernel.org,
	linux-alpha@vger.kernel.org
References: <51ce38fe2fa34ec79ad07a96feaea597af07bac7.camel@physik.fu-berlin.de>
 <CA+=Fv5RaMF2ohojG+U0MG-dpLHS4x-Tc41+fOLZwrWqu7T0L0A@mail.gmail.com>
 <CA+=Fv5QH1nUO1D1=Osqic6mNN6vLxiLqvNA4D9uAUgZA_w+7Tw@mail.gmail.com>
 <0b338882a82c3f505407cb313b89a2c7f891d982.camel@physik.fu-berlin.de>
 <CA+=Fv5RDcgm4YSX1AcpOgLvL=XXKyA=71ZasbJSc7+79Kh_Xpg@mail.gmail.com>
 <d9330edfca0fb34c69a68c56924fa0b074b26d29.camel@physik.fu-berlin.de>
 <CA+=Fv5T9nrQjGHOR+42tfgT723TJGgyVqBY7CwY4L-gYSoWTag@mail.gmail.com>
 <c661a771a86267c158d7f2eba1494fe94350fb06.camel@physik.fu-berlin.de>
 <CA+=Fv5Rxrwn0SEMgjufJcxSaB0_gOiKBjXuZnSKzgKakDHeCOw@mail.gmail.com>
 <CA+=Fv5R+8y2hCq7p-xo5qZ0CyinR_0aAndUkoEAweCVs_95SMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+=Fv5R+8y2hCq7p-xo5qZ0CyinR_0aAndUkoEAweCVs_95SMw@mail.gmail.com>
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --

On Sun, Dec 08, 2024 at 10:39:30PM +0100, Magnus Lindholm wrote:
> some updates:
> 
> I've been building gcc from git and this is what I've seen so far:
> (GCC) 14.2.1 20241208 does NOT work
> (GCC) 15.0.0 20241208 (experimental): works!
> 
> Seems like this bug gets fixed in the 15.x branch!
> I need to find the commit that fixes this...

Maybe, maybe not.  Building 6.11.11 with alpha-linux-gnu-gcc-9
(Debian 9.3.0-22) fixed the null pointer access in the scsi
subsystem, and finally I have a bootable system! (Tested on ES45.)
But I now get a null pointer access when network driver loaded:

[   34.501935] e100 0001:02:04.0 enP1p2s4: NIC Link is Up 100 Mbps Full Duplex
[   40.692361] Unable to handle kernel paging request at virtual address 0000000000000000
[   40.799783] CPU 1 
[   40.799783] kworker/1:2(158): Oops -1

Cheers,
Michael
