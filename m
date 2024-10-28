Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E0115C13A;
	Mon, 28 Oct 2024 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131667; cv=none; b=YhS1S33R2gN+JeO42FUUc9bEct7+F1D9gIfZVIT2VGiAaN6uhJIwiYEFKHPaPkSOfRfrLPixVzWwaqBXDnECdoUz8N8U6DnQCwY0nSTrdQNPiALlAP/JCrPgYNr8WrrN2hmNGUq5pzHBRBgodaHp3OETZkV4mOUeJEO8jYWeWrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131667; c=relaxed/simple;
	bh=SgXnHFcqu9qS1DL9LAwZ1/EWLdvMVq9awvLT56iJu9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDZ+6aWVFNnPOJ2R/rIzJ+f2ccvJ0qXkhQJ+Nev1K4X80r2+IWH3z7LR/2z/E+i2xq8A95lYHZ7ENelkrnrQKhwAlManeV/kfPWUsA2B4g+gqG8s+F8ruKU2Co13IyF0sWUtR/YBfIrD5YxRqp6tH7ghpnfONnsUKw8kd2rG6ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYyh6kON; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYyh6kON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5297AC4CEC3;
	Mon, 28 Oct 2024 16:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730131666;
	bh=SgXnHFcqu9qS1DL9LAwZ1/EWLdvMVq9awvLT56iJu9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYyh6kONC4YpCAn6YIdN6OfZaudgrF2NkdsDBUHD0Z/3oBstvtDU7272cb2IeEfwf
	 jchMPXf4956DLfoiY6UkJJVCG5RUYUTDeH6++md3yTVi2zGor3xBzR2caV23RdAEWR
	 6e/7+sDvELWokdknPaWmi/YEppVrLnCDSkVjDESfCCGdAPVejYLfcWBRrmFZvKXdHG
	 ZbIYLe031ySoq8sJ7M75JA3jI+lIUH/IKgVjw8wNG6OuABCBLV63vpDdFlWuWYIVcB
	 XhzV6jIxKoE/qvu945BDwA+gk+xOj7nsrGB95WxzRuwsk4VIiBOvL8Ngsz4tCSolZi
	 v55bcjmKXxSXg==
Date: Mon, 28 Oct 2024 17:07:43 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/2] rcuscale: Remove redundant WARN_ON_ONCE() splat
Message-ID: <Zx-2z3-abgyDG3VM@localhost.localdomain>
References: <20241024164558.715296-1-urezki@gmail.com>
 <20241024164558.715296-2-urezki@gmail.com>
 <640af17a-958c-4321-89d4-8ab1f12986fb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <640af17a-958c-4321-89d4-8ab1f12986fb@paulmck-laptop>

Le Thu, Oct 24, 2024 at 01:28:24PM -0700, Paul E. McKenney a écrit :
> On Thu, Oct 24, 2024 at 06:45:58PM +0200, Uladzislau Rezki (Sony) wrote:
> > There are two places where WARN_ON_ONCE() is called two times
> > in the error paths. One which is encapsulated into if() condition
> > and another one, which is unnecessary, is placed in the brackets.
> > 
> > Remove an extra WARN_ON_ONCE() splat which is in brackets.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> For both:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Both applied!

Thanks.
