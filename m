Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F03CC25B08
	for <rcu@archiver.kernel.org>; Sun,  7 Aug 2022 18:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbiHGSME (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 7 Aug 2022 14:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiHGSMD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 7 Aug 2022 14:12:03 -0400
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8339663B6
        for <rcu@vger.kernel.org>; Sun,  7 Aug 2022 11:12:02 -0700 (PDT)
Received: from 213.219.160.184.adsl.dyn.edpnet.net ([213.219.160.184] helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1oKkkd-0007My-9Q; Sun, 07 Aug 2022 20:11:47 +0200
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1oKkkc-007e4J-0N;
        Sun, 07 Aug 2022 20:11:46 +0200
Message-ID: <98995bb4511c87e82820ee12691d2b095358beb2.camel@decadent.org.uk>
Subject: Re: [vfs-next] RCU call-traces (task: modprobe)
From:   Ben Hutchings <ben@decadent.org.uk>
To:     sedat.dilek@gmail.com, paulmck@kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, rcu@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de
Date:   Sun, 07 Aug 2022 20:11:41 +0200
In-Reply-To: <CA+icZUX6q32RX3g6KNqvaaD2ub1cL5U6-YWPq=Nao_HvQTy95w@mail.gmail.com>
References: <CA+icZUWUi_BJtjmewptMZWPUOT07FWBxu3A3yQTc-vM_F2XgTA@mail.gmail.com>
         <20220806163247.GZ2125313@paulmck-ThinkPad-P17-Gen-1>
         <CA+icZUX6q32RX3g6KNqvaaD2ub1cL5U6-YWPq=Nao_HvQTy95w@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-/FfgOveXKofaGFtyiQAH"
User-Agent: Evolution 3.44.2-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 213.219.160.184
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


--=-/FfgOveXKofaGFtyiQAH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2022-08-06 at 20:48 +0200, Sedat Dilek wrote:
[...]
> Right now, I installed latest Debian-5.19 kernel to compare the Kconfig v=
alues:
>=20
> [ Debian ]
> $ grep RCU /boot/config-5.19.0-trunk-amd64 | grep -i stall
> CONFIG_RCU_STALL_COMMON=3Dy
> CONFIG_RCU_CPU_STALL_TIMEOUT=3D21
> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=3D20
>=20
> [ Sedat ]
> $ grep RCU /boot/config-5.19.0-2-amd64-clang15-kcfi | grep -i stall
> CONFIG_RCU_STALL_COMMON=3Dy
> CONFIG_RCU_CPU_STALL_TIMEOUT=3D21
> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=3D20
[...]

This is because of CONFIG_ANDROID changing the default for
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT.  I'll cherry-pick the commits from
5.20 that remove that misfeature.

Ben.

--=20
Ben Hutchings
I haven't lost my mind; it's backed up on tape somewhere.

--=-/FfgOveXKofaGFtyiQAH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmLwAF0ACgkQ57/I7JWG
EQk8yA//fOE98y+Is9MTqDDB+BH7rWQavmT/B0B/y87rkNHmtM02E6jEQ6FfDYIP
3R2V/nyFFicxkjzb8gu4W0cMy/tJS2yF9hH5c3kPWt6vb0QT36UTDiOho3C1b47q
pOitRxZPkYo/8eNXtxk5wkcmMmwEn0y5Ht0h6KzdAG9Qcbre9xrftv8SHEYAlSAi
6cx0/5+H+P5lNXHMqlZ3RfEengFPFpUAN9R7sArOHg9uDMCNsrPUm1wikOxy2KeU
d1PWfWNL2SPzEG9rttqIQiRdKVF+5Is2/twAjp1K0jD4d+fMbVmakH0sqwf7RGHl
vndmNlJ/bREAtJm6v5LIbfPgfJjW3tn9GY9VKww6fJihvaEyxbOQZLqCOnHzjJOB
hkV5Bma+q4nuwBtzfQz7/yQj9eYWIp76V7txZTDYIdl47QxP6d6fAusslOMSF2EV
OwYf8mU8DpvXmw/1+1Zit57+ItiyZb2br9B9lc1xdqrKKlHYuigbE2iw3OpSY7Mw
3lqp9rm+AbewP0+dXmAwL8mJU1c9jq0iT/N8kM0UsqO7tnYiRF29JeVJ0Z6X9im4
TqweR4o5YwL7QRDpSIivxl+Doct7WTouqZsyGAEiF8Ergak6TR+Pkd8RzAfT66q4
FnSgtVr69ATaCN1F//t1zAKR5k1cp/n7R/TBM6OdnOITx6VTmuo=
=pNda
-----END PGP SIGNATURE-----

--=-/FfgOveXKofaGFtyiQAH--
