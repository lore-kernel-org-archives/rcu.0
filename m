Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BADA42070;
	Fri, 27 Dec 2024 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735300131; cv=none; b=IdY6FxaIuBsBvtuZOG7xRJrJUw31girgxFiD/l7W30yTBVuv2+ltdJzml7W1t7KS8I2UQrACXNWImvCyVd3oegGTs7TZX191LF/Hkulixa/S5vllV4jOzQnEGpUPj468RdN9QgiiBP63TF0BFlwxWc7UnGZYklx7iYTLhDwnMfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735300131; c=relaxed/simple;
	bh=NyIjsxP7hLdhQx5rqI8thDofmltetYsKWrqF5omzlvc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r0ZIvMuQZQKkL6SeAzrzYgaL4KG9/cjo8X1zPXMn7YMY4/PltSlA4Ov122yWyk+hSO1Yt83UmdDKXisDbjI4SPdzu5sX+O5jToqBAlTQT2TPtz/3atVKrKxgolaTd+rqA3xyQPsqrmrhX77xfF8riPBpN3VK9yqMcmcSbH+pphM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=mvdk0sz/; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="mvdk0sz/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AnrCj2REncAYtqLUkwdLwQJ4yHzFo8R8XcPdjRYdx+w=; t=1735300127; x=1735904927; 
	b=mvdk0sz/JAtKgMgMFfXMSCsuuo5YMCCFXLIPiukuVTLiXb7fugvA3OWsfaS6UGa8FqFCTC2LDRJ
	WhZ9LUO2NphxBIYmYoAaVBbpiTrfODELCeaDzrk0hAFuNO4MBJ8GQ9TgSm76lXvaLuce3P+RoWr4i
	EYYbEqOLzmYKWg9iCl5Nv4f/ZugTsir6491wHq3SVDjfxGx/Rvuu6QCM1uFKiMzclS+3tyU2HQQqi
	C4zNN9bn7NP7bpLiy2eoj3EaTgv9vWaSYyL6xQg9Y4EeAKShdLiObdnXAjgFTbNghPattgnJarxmu
	yuscnB0uiJu+nLQrbKVQrWXJJCx91WnGw07A==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tR8pa-00000001IWy-0qbB; Fri, 27 Dec 2024 12:48:38 +0100
Received: from dynamic-077-191-186-045.77.191.pool.telefonica.de ([77.191.186.45] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tR8pZ-00000002CQz-48LF; Fri, 27 Dec 2024 12:48:38 +0100
Message-ID: <4e3a93da86414add80784db70ae2ebe255ae75ca.camel@physik.fu-berlin.de>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Magnus Lindholm <linmag7@gmail.com>, "Maciej W. Rozycki"
 <macro@orcam.me.uk>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Michael Cree
 <mcree@orcon.net.nz>, 	rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Date: Fri, 27 Dec 2024 12:48:37 +0100
In-Reply-To: <CA+=Fv5TJhDrrxG82=MNPFEFFwKD4NDYyB1u32ZvnGv6Ma0h_Nw@mail.gmail.com>
References: 
	<CA+=Fv5R+8y2hCq7p-xo5qZ0CyinR_0aAndUkoEAweCVs_95SMw@mail.gmail.com>
	 <Z1YpKFQGtMWF3yy3@creeky>
	 <CA+=Fv5Q=f-6y=EhZhG2XfZB0O=m+yOiv+gmtmMABVQZieKdwbQ@mail.gmail.com>
	 <Z2ClSlwznfuk8Uwr@creeky>
	 <CA+=Fv5RaqHL6MJjvhF-mn3CVY10e=2QqFBSVO6YXLUJ7WV9zGQ@mail.gmail.com>
	 <CA+=Fv5RP=NoWo4VeTX7hx103=jP2d-NC-jFo+ePXLBRubCxc_w@mail.gmail.com>
	 <ef49a479-2000-42ee-9b10-9f3b6a68ec35@paulmck-laptop>
	 <CA+=Fv5REK+xbA49zD3aYBgG2J1Xw1FWP02qjyyOTrwbzMRXu3w@mail.gmail.com>
	 <be4fe590-b41c-4033-91c1-94f10c4f3d40@paulmck-laptop>
	 <CA+=Fv5Tk-vbAK72ZOK-bPwvnx9w_1ATH=S9t-LW8gBEgQPYa3A@mail.gmail.com>
	 <b3cd5af3-4b8f-43bd-b3f3-c9f4644c95d4@paulmck-laptop>
	 <alpine.DEB.2.21.2412192347450.20821@angie.orcam.me.uk>
	 <CA+=Fv5TJhDrrxG82=MNPFEFFwKD4NDYyB1u32ZvnGv6Ma0h_Nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Magnus,

On Fri, 2024-12-27 at 11:42 +0100, Magnus Lindholm wrote:
> >=20
> I've done some more testing last couple of days and it seems like
> applying the one-liner "fix" to smp.c (alignment of csd_stack in
> function smp_call_function_single) is sufficient to mitigate both rcu
> related bugs (the bugs are not even rcu related).

Could you post the patch? I would like to give it a try myself.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
