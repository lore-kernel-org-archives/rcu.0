Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E592221D018;
	Thu,  9 Jan 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438227; cv=none; b=FAhitq+V2LGsbUxXohm/ptKKSun3SxZzlCzSpHXh0Zui3ZDV8ls+Pq7m0kTNibgGoYV0AySeVFVjHY3rZu+YeKCcecuF7wKWc6NjIKK0tNgs0Y3zlsCA2AVarkb+bZhGN0dl7XrBgtZ1BWDQE6p1rT1OChlvISc5zis/j45E0IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438227; c=relaxed/simple;
	bh=5jW3M/FEGHV8wyeQCwWKolLDkAf/zpTHisvRnNMHncI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ovqoustM9GrvQOPATV5OAc2yjAS0g9GWbt0goawJc00+GdqIQZyda/clIEnZU/aVstg+5rLX/fw/Qqnk+4bqQt6YjDfgknv2x87lunwTS80045sCNdBpMHZJfnI7mrCOKESFnQ++/xF0cSBE3bB2f6/Q0u9KXwyTZlS/vGcn21M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 2AE26160197;
	Thu,  9 Jan 2025 15:56:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 8D84F2002D;
	Thu,  9 Jan 2025 15:56:55 +0000 (UTC)
Message-ID: <ae3a285f61f087aed7aa0355d8ca6025994d4119.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Remove migrated RCU APIs from
 deprecated_apis
From: Joe Perches <joe@perches.com>
To: David Reaver <me@davidreaver.com>, Andy Whitcroft <apw@canonical.com>, 
 Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
 <lukas.bulwahn@gmail.com>, "Paul E . McKenney"	 <paulmck@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, Krister Johansen
	 <kjlx@templeofstupid.com>
Date: Thu, 09 Jan 2025 07:56:51 -0800
In-Reply-To: <20250108192456.47871-1-me@davidreaver.com>
References: <20250108192456.47871-1-me@davidreaver.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: 3qnbbqb8zpksamuht9ytqwibfgre4cxg
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 8D84F2002D
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18JtjaUOQ3BEFxizEdnOFI7tDFcg8h+7ZQ=
X-HE-Tag: 1736438215-493715
X-HE-Meta: U2FsdGVkX19UnnCKjX0dZSIBYdH6eQqkbvROHVyDrp4uLCK9IpYmXvl9zhuQgdrIX9U2AGhsWF/b9d37H1AG9y7XwJgYk7rEnBOdgrvqjl8d/UZ29dYuoN+bHIJYBYoEHMQMZjZipjqoizemoPregsma883IXMcjvlaQFzOFFfwbupaFq2XDlUwQGCKiIuCkY9fVZE/uuGTn/wAJ7qrFwisy+n7ufCw7f6ljFRtsJ1RSFn9bR/QbnQj8s7C/JXylkCOz8ctpL1oUCYyUIvsPoRJMTvAIT/KwxysJ71GInjuRqYLmEP/7QVP15TCWU97NXKQhtrscml44qUNLBuVPSPYZiyHR4UP4Q2w6HHz8wkZl6c+rTWhGYk/LlJk/AxrDejdI5ll0PjkIh5/RjttnTPZPEFMia3usaJYqtDgX5EIUyoIfiSnhnxGJ8QERoFDST5uWdsA52OgSJ8jIO5D7aD1g15AKY6itEq8sgGmJa38=

On Wed, 2025-01-08 at 11:24 -0800, David Reaver wrote:
> The deprecated_apis map was created in [1] so checkpatch would flag
> deprecated RCU APIs. These deprecated APIs have since been removed from t=
he
> kernel. This patch removes them from this map so checkpatch doesn't waste
> time looking for them, and so readers of checkpatch looking for deprecate=
d
> APIs don't waste time searching for them.

Acked-by: Joe Perches <joe@perches.com>

Maybe remove the references from rcupdateup.h one day too.

>=20
> Link: https://lore.kernel.org/all/20181111192904.3199-13-paulmck@linux.ib=
m.com/ [1]
>=20
> Signed-off-by: David Reaver <me@davidreaver.com>
> ---
>  scripts/checkpatch.pl | 10 ----------
>  1 file changed, 10 deletions(-)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 9eed3683ad76..842a39a01af1 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -834,1 +834,1 @@ foreach my $entry (@mode_permission_funcs) {
>  $mode_perms_search =3D "(?:${mode_perms_search})";
>=20
>  our %deprecated_apis =3D (
> -	"synchronize_rcu_bh"			=3D> "synchronize_rcu",
> -	"synchronize_rcu_bh_expedited"		=3D> "synchronize_rcu_expedited",
> -	"call_rcu_bh"				=3D> "call_rcu",
> -	"rcu_barrier_bh"			=3D> "rcu_barrier",
> -	"synchronize_sched"			=3D> "synchronize_rcu",
> -	"synchronize_sched_expedited"		=3D> "synchronize_rcu_expedited",
> -	"call_rcu_sched"			=3D> "call_rcu",
> -	"rcu_barrier_sched"			=3D> "rcu_barrier",
> -	"get_state_synchronize_sched"		=3D> "get_state_synchronize_rcu",
> -	"cond_synchronize_sched"		=3D> "cond_synchronize_rcu",
>  	"kmap"					=3D> "kmap_local_page",
>  	"kunmap"				=3D> "kunmap_local",
>  	"kmap_atomic"				=3D> "kmap_local_page",

