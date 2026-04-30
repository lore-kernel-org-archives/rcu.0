Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645FB5474F;
	Thu, 30 Apr 2026 00:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777510614; cv=none; b=Ie1aPiYtf02iXB/yXtITmYBjeEWEY5jLBPIV9p2Ggw0t0cya2rYjGv0CCBnQ3082ERogL5hdieHr0f1p6+fhXhTISnjiumi9e70EwKr65pHlUtRDIP7xdVPInroLC7yi06UeDEZ3xc348eh+GiEjk20et67eV2SnjVSYcynaT/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777510614; c=relaxed/simple;
	bh=iKtlWudWf4yk0Lw+o/8AER/401ttw3Z21zzRCj0TtyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=selw3r+Oqx4I1ovnTtaZ0gVV0M4D3Vz78bawv0+MqhRsRsGVR4tukbYYz/23DNNfZVOAAnDG4YlcweFFaNJZ33C3ko4tVbV8V3woeeEb5vUeJi78dU7zSoL9Qijo1suXRRPi0Pke2OHv0R27LKZNHuht38LXGHM6WBudlfGVRRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5O0uOFk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5O0uOFk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A82FC19425;
	Thu, 30 Apr 2026 00:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777510613;
	bh=iKtlWudWf4yk0Lw+o/8AER/401ttw3Z21zzRCj0TtyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T5O0uOFkB400nD6lpKCMSJhkVo3JAz+oQGI4I1AYyFmKnID7GhY3MajEdF+gonuiy
	 kPw3kFuwGCWFPghkeNq74M1zRcFk70/Wo4/o9hspxulsq2lf7V/eTaRMy614D2ciUT
	 IAteBdqdhamoTivv77BZCpUNVGVefsA3TcbX1UWAub8ExTz1cVkRlHIOyF3JyCtffL
	 ZZKWYQGCVQcMiekKxKI6t7btxPXWVTxNPREnHs9RlP9iEvuvw4ro4J5bLri11gswva
	 KopiZLOt598FQCTMPWZoYxukgy/SOJSb0nBoyZxHrk5qFfqRHf3Ihbah1Po8vp5z7O
	 vxnlv/dNKN6Cg==
From: SeongJae Park <sj@kernel.org>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v4 2/3] Documentation: RCU: adopt new coding style of type-aware kmalloc-family
Date: Wed, 29 Apr 2026 17:56:45 -0700
Message-ID: <20260430005645.113819-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429072320.310817-2-manuelebner@mailbox.org>
References: 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 29 Apr 2026 09:23:21 +0200 Manuel Ebner <manuelebner@mailbox.org> wrote:

> Update Documentation/RCU/* to reflect new type-aware kmalloc-family
> as suggested in commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj()
> and family")
> 
> ptr = kmalloc(sizeof(*ptr), gfp);
>  -> ptr = kmalloc_obj(*ptr);

Shouldn't 'gfp' parameter be kept?

> 
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>

Other than the above,

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
