Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CF8EB64D9
	for <rcu@archiver.kernel.org>; Wed, 12 Jul 2023 10:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjGLKMA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 12 Jul 2023 06:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjGLKL7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 12 Jul 2023 06:11:59 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772571993;
        Wed, 12 Jul 2023 03:11:58 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B9CD31C0E01; Wed, 12 Jul 2023 12:11:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1689156716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l2Y4PoQq7t84wSDXhTjv7xxRnyRD7me00mbEwlLgnHk=;
        b=HSznmEO/ofiqKcE49Py+QgfRHivNm06Si3TCpCQUabEBo/MKU7poY5N34pV+UlECSTg2k0
        r9L7WQcnWAcFUtZF9U+kTrKDaeo36HbREFgXaiiiBOjW4eYhPLt1+dvUrrmAFZfvLm43dO
        JRDSfU8UiuP+TOMx3hGqYvm4o+1SY0A=
Date:   Wed, 12 Jul 2023 12:11:56 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>, frederic@kernel.org,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        josh@joshtriplett.org, boqun.feng@gmail.com, rcu@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10] rcu: Mark rcu_cpu_kthread() accesses to
 ->rcu_cpu_has_work
Message-ID: <ZK58bFy80qmsRI/c@duo.ucw.cz>
References: <20230702195806.1793552-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="T5plQyocUu8y0Gz4"
Content-Disposition: inline
In-Reply-To: <20230702195806.1793552-1-sashal@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


--T5plQyocUu8y0Gz4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2023-07-02 15:58:06, Sasha Levin wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
>=20
> [ Upstream commit a24c1aab652ebacf9ea62470a166514174c96fe1 ]
>=20
> The rcu_data structure's ->rcu_cpu_has_work field can be modified by
> any CPU attempting to wake up the rcuc kthread.  Therefore, this commit
> marks accesses to this field from the rcu_cpu_kthread() function.
>=20
> This data race was reported by KCSAN.  Not appropriate for backporting
> due to failure being unlikely.

Please drop.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--T5plQyocUu8y0Gz4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZK58bAAKCRAw5/Bqldv6
8rD3AKCF4LKQV/oMG3jBaJY+I5XJc8o0+gCeOWkaQmErzClV1y77SKWv2TSDAKA=
=R0/9
-----END PGP SIGNATURE-----

--T5plQyocUu8y0Gz4--
