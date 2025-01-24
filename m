Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06801D63DF;
	Fri, 24 Jan 2025 06:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737701986; cv=none; b=tsexBXf2jIfOQlsnKa3Ljp5B8MP1CsKWG0xeoDSSYVuT94Rfmd8ynmjbdU4wURA4UasmpgnIg/0nT3x9+UdmqgX3q61f0aUMMw0fB+/2v1CmjwCXGnaOQkF7NDFjiwzlPclPqtMwTaCmGLiHG9d4oQaH9OURHrhe6qzHGi2r39c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737701986; c=relaxed/simple;
	bh=Mh16fg0NFrM3nHQSA7prhabj6UUfDhhzFduubR0jnR8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IV/Ah0EESHqivoHNencGvB5sn9wJIIJ4bk5ETYphWW/CuIzFn1LHCazMyavygQgLxdGQYHJ0d4K6l9dPgbUoEtE7NUVx0NLe946JDkCd4NylQ4GphxmCuykRnbcGz7dRZXwfd0NoKRqe0NPK0xvJ4I2SaeXfPk8uBI/xB4AIb4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Nx965ON8; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Nx965ON8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rYviyEH/DiUlNU438wR2Zv7CPX91BT08vko5U8a3r0Q=; t=1737701982; x=1738306782; 
	b=Nx965ON8pGJU+SHuXApOZjtns9FxIt6+gDcYdHn5X79howZfPIIDQNi1Kw7r6q2Nagj4PUnn0cz
	e0V7vbcmyw3tu0izujls1Uk4njzrKV6Wj4uZwXgZHwfpDiI328yvMCEVWFXGoYr/gWBVI5uGxAMXi
	Sl1awN9xQkPF/bp2EId79opq7jUpUjTDCajeJuhDfo1pzHcpGXxHXGXYpreer91+zatSBLfAVYWA2
	8lZKDmuZ4PdKgwx32HMlHuVQA5ZM0UWwvORUmdvvaVIS27An/Al2e3WW4dUsdCu6m0jbG/aEpIehV
	3Fg6N5bgJdosogPcOKhw4q0Le7zoVyMjsHaw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tbDak-00000003Ekp-3WZH; Fri, 24 Jan 2025 07:54:58 +0100
Received: from p5dc55cec.dip0.t-ipconnect.de ([93.197.92.236] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tbDak-00000001e76-25TG; Fri, 24 Jan 2025 07:54:58 +0100
Message-ID: <069a5d733ee3cf807f1e53ecff6bf4c0d04d457e.camel@physik.fu-berlin.de>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ivan Kokshaysky <ink@unseen.parts>, "Maciej W. Rozycki"
 <macro@orcam.me.uk>
Cc: Magnus Lindholm <linmag7@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>,  Michael Cree <mcree@orcon.net.nz>,
 rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Date: Fri, 24 Jan 2025 07:54:57 +0100
In-Reply-To: <Z5KMHoA7GlHJyUU_@minute>
References: 
	<CA+=Fv5TJhDrrxG82=MNPFEFFwKD4NDYyB1u32ZvnGv6Ma0h_Nw@mail.gmail.com>
	 <alpine.DEB.2.21.2412271452100.20821@angie.orcam.me.uk>
	 <CA+=Fv5SW-N+5KzsnVdHvy406-p+g7giUbt626xwDduy6xjaPkw@mail.gmail.com>
	 <CA+=Fv5TtOQkDMPnuPrPGcB0VGhUHUDqe5=Z+ovd5x5rBJ-Hsjw@mail.gmail.com>
	 <alpine.DEB.2.21.2501122348510.18889@angie.orcam.me.uk>
	 <CA+=Fv5Q9UxeSP0U10d281Nbm3agyFgpwyY95+d2pAWVWJP=2Yg@mail.gmail.com>
	 <CA+=Fv5RU946-r5S8hZKTF4w20s82Oc-JDe-pCa1W7zjr6nEoag@mail.gmail.com>
	 <CA+=Fv5RntE=Z=PgYYxBDLTDES6aWkg-+yqEPPDjv-E7GCcoufg@mail.gmail.com>
	 <alpine.DEB.2.21.2501201317060.27432@angie.orcam.me.uk>
	 <Z4-jgMJgbVriLaCr@minute> <Z5KMHoA7GlHJyUU_@minute>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Ivan,

On Thu, 2025-01-23 at 19:36 +0100, Ivan Kokshaysky wrote:
> On Tue, Jan 21, 2025 at 02:39:12PM +0100, Ivan Kokshaysky wrote:
> > Indeed, SP_OFF in entry.S is the main suspect at the moment.
>=20
> In fact, it's the odd number of longs (29) in struct pt_regs that makes
> the stack misaligned by 8 bytes. The patch below works for me - no more
> oopses in rcu-torture test.
>=20
> Unless I'm missing something, this change shouldn't have any ill effects.
>=20
> Ivan.
>=20
> diff --git a/arch/alpha/include/uapi/asm/ptrace.h b/arch/alpha/include/ua=
pi/asm/ptrace.h
> index 5ca45934fcbb..d2e8e69a18f1 100644
> --- a/arch/alpha/include/uapi/asm/ptrace.h
> +++ b/arch/alpha/include/uapi/asm/ptrace.h
> @@ -49,7 +49,7 @@ struct pt_regs {
>  	unsigned long r16;
>  	unsigned long r17;
>  	unsigned long r18;
> -};
> +} __attribute__((aligned(16)));	/* GCC expects 16-byte stack alignment *=
/
> =20
>  /*
>   * This is the extended stack used by signal handlers and the context

I can confirm that this patch fixes the SMP problem [1] for me.

Thanks,
Adrian

> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D213143

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
