Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693671E521F;
	Tue,  1 Apr 2025 06:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743490418; cv=none; b=G5BxTUGtu4FyPv1/g55E2rC2sGthKmLfDLJClYEGDvoyZ0gdvQ4HVdbEivxRcEqv6CjEsGk/dXHrsz5UCIwhsISHywtIlI78wI7XNULQlYe5qUhLXFDly4IXEMK1M/RaDiCIz/LyqvM9/UXTLrQ7kZHRzCtGeSEmsxqR827w3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743490418; c=relaxed/simple;
	bh=Z/JiWl6m6AmAp7HWDZOAQ4d1vXZwzy0vWUbyGyasr8g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ob6szW4WcqRqWM873xLKSN9Tp8zMWf72Ll1qtj8C8cjsi/3ZGVW3FcWNl3PYwZU3LZH/+bTKIUfRVfMwa6fTJQ55XSdwV6rDbHh9x4siZqd44giUIlDZAU3oY5/HID22CfgqZ7jnj4+uS1Pd4VLjpYz46jSL/4wW99C+jrw56d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 0C3B8141518;
	Tue,  1 Apr 2025 06:53:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id CEF2C20013;
	Tue,  1 Apr 2025 06:53:26 +0000 (UTC)
Message-ID: <5588e91ab302e21bf4e30b5208cf3d387f8e7de4.camel@perches.com>
Subject: Re: [PATCH v2 10/12] checkpatch: Deprecate srcu_read_lock_lite()
 and srcu_read_unlock_lite()
From: Joe Perches <joe@perches.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, Joel
 Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Date: Mon, 31 Mar 2025 23:53:25 -0700
In-Reply-To: <20250331210314.590622-10-paulmck@kernel.org>
References: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
	 <20250331210314.590622-10-paulmck@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: CEF2C20013
X-Stat-Signature: niz5i9ektetyr84ussoegaozkngtw18i
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19d/wOrO6ys9m7Y/fQ1C035mkLkvjuVOHc=
X-HE-Tag: 1743490406-158160
X-HE-Meta: U2FsdGVkX1+6HqO32Y6ezF9adgzOiPUdjxha4GerFw2KW4Y9s1QZ1zWc5yDCBRKYxQjI/DN2bZZlF99V6PfxPdqAXY7wYZpQ9+628wnlEwMWuhCLRb9dZAVbKBWL6gKGCseBx35OlmqnKmFdKjh33Bm9kT2Kg9eiHHKCO4ik+rDY8mOyVnI4zQeBhY80CZHMWzshxjjpjGojSUrNMZRCJYhJiLROlXAmip/MkyPJY23iMVM0y6xqsl27RTQZoiY+R/HoqJl8VIkiAXpHGmMH0mVtE3jmAgZ4QFW+WiDWrCaQ4ijTNY82YZN/GVJ3lrlZMoQWgyEYYLfdrfIvHFAdBGeUlLcFPB2D

On Mon, 2025-03-31 at 14:03 -0700, Paul E. McKenney wrote:
> Uses of srcu_read_lock_lite() and srcu_read_unlock_lite() are better
> served by the new srcu_read_lock_fast() and srcu_read_unlock_fast() APIs.
> As in srcu_read_lock_lite() and srcu_read_unlock_lite() would never have
> happened had I thought a bit harder a few months ago.  Therefore, mark
> them deprecated.

Would it be better to convert the 3 existing instances?

>=20
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  scripts/checkpatch.pl | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7b28ad3317427..de8ed5efc5b16 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -838,6 +838,8 @@ our %deprecated_apis =3D (
>  	"kunmap"				=3D> "kunmap_local",
>  	"kmap_atomic"				=3D> "kmap_local_page",
>  	"kunmap_atomic"				=3D> "kunmap_local",
> +	"srcu_read_lock_lite"			=3D> "srcu_read_lock_fast",
> +	"srcu_read_unlock_lite"			=3D> "srcu_read_unlock_fast",
>  );
> =20
>  #Create a search pattern for all these strings to speed up a loop below

