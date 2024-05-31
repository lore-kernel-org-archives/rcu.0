Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C9360
	for <rcu@vger.kernel.org>; Fri, 31 May 2024 00:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717113964; cv=none; b=eM2LgDKwDl22UPQsLCl9wXbqpyCYmxS97X88Vs5JVJEdO6Ivj4oxmHMXf1QyNaNqPqcwDajk0sRBgFDVl9cQ9EHF5jdwWfmGeHw6sH2wsNgU4FJFY3TSFS+gJI9Td4tUnO4lPJyPSX+N90BV5unTAd47r6tEgjWluGEZ/SAM498=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717113964; c=relaxed/simple;
	bh=txTUgJDvPS3jAWe3lxGA4rkNVIQYuk5eEN2Gys4iJdc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNN9yB0F7tTnBvUovRg61iyNkxAXgahsND+6L8nD4mJ1xLZBBmeKDAv/JZOyfb1RrzDgxMAwWhD9/vOlXuZBVElm5YnFxjEbNABmBQMbsK0Dk/VySQzXl66cze3NGipUs9cB4FdxELbH++vsy1DVdPwd07tYXGqxWfV1tPTvPiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=R5di9EQS; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="R5di9EQS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1717113951;
	bh=txTUgJDvPS3jAWe3lxGA4rkNVIQYuk5eEN2Gys4iJdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R5di9EQSmElLNvFJ7g9rxM8pIQ3qLhRDEIAf5Xs/3d4bIukIrBUGnGUQbbveEFxJG
	 QOzwA2LSzaZZ1yvW2OT8wU7GK+fXewFw2t9H34zsFldK17SRPLc478BmV2gpyogtsc
	 KI7uCqt95oZzOYJRzZg9tyzbpozzWwwdB/9PK2uWn5TK+QRBBUQUkQplciJwTPR1Rr
	 aPUce+OXUFR9fmJCXuLmnwMCnQZ+zM2Da9RSdpe/5wO6OP/pH3Mm26qrINUPoCr/UE
	 642Xsjkz9/niY03/Lrp1WxhrGO5uyGEmVQC3nUBXjwPtdN7oJ09dOhvyXTK+Li1m+3
	 eC4yvb5cFtHiQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Vr3L72TGhz4wcC;
	Fri, 31 May 2024 10:05:51 +1000 (AEST)
Date: Fri, 31 May 2024 10:05:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com,
 urezki@gmail.com, neeraj.iitr10@gmail.com
Subject: Re: Updated -next branch and repo for RCU commits
Message-ID: <20240531100550.664ec884@canb.auug.org.au>
In-Reply-To: <0cb42d29-4c2e-412d-82af-0f2e42b40669@paulmck-laptop>
References: <9ad62150-b699-4662-9b7b-89bfdbf6a8e6@paulmck-laptop>
	<732c43ae-6d7a-4a98-995e-e96086a94678@paulmck-laptop>
	<20240529080212.21a8ab42@canb.auug.org.au>
	<0cb42d29-4c2e-412d-82af-0f2e42b40669@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/830YglATXo0YrhTuAIWc9JS";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/830YglATXo0YrhTuAIWc9JS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Wed, 29 May 2024 15:21:05 -0700 "Paul E. McKenney" <paulmck@kernel.org> =
wrote:
>=20
> Please make the newly renamed paulmck tree pull from "non-rcu/next".
>=20
> The additional contacts for the new shared RCU tree are:
>=20
> Frederic Weisbecker <frederic@kernel.org>
> Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> Boqun Feng <boqun.feng@gmail.com>
> Uladzislau Rezki <urezki@gmail.com>

All done.
--=20
Cheers,
Stephen Rothwell

--Sig_/830YglATXo0YrhTuAIWc9JS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmZZFF4ACgkQAVBC80lX
0GyFsQf/fiYvABCTajah5HFrnLmRKk7dXj3fQ+udsAGCmuoRuEMDhHDITMDL5DFE
rQYASH07jt5qzaY69IRSmyDgr98gd+/T+CqsQnUL+xHaXJ3DzKalf7EDP7Y++Kjv
CM/VjHhojyaEFvWqhlnKeaVjB2rtUmti7UYt43EUEm+x49gq1trjuRzSt6k2OKuf
HRHr5I8sH904BGLgtO21O/uCrMllFaoopbq75s1HFXzTX6EJCfCjII6saFJjdpWn
t9HEgmvMLnrqkj5Xkv10K3EMFvUIyxMxYGBS/QVoKXkNDRuRro2RxMKfpXS2Owuz
DpgxL5E7udYtdXZ8smR9dwN7JA+sww==
=Tocw
-----END PGP SIGNATURE-----

--Sig_/830YglATXo0YrhTuAIWc9JS--
