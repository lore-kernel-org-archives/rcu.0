Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C03E2837B;
	Fri, 16 Aug 2024 07:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792237; cv=none; b=CDul8nm4HcvPJ3oOFqybk6ZnyercxSsJkPkPeNlVcmyEHEoJcVJPjcRD5xndN0NcCE5BqvmLYIpZkD0sHRs+uPMXYYReKxX6OL8nRmKWZywXLy22iBGkhQt6QbsilWwruieWwulpDXrnaYpkw4dHjOZtseQhCE4ATrTpIJwVe0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792237; c=relaxed/simple;
	bh=jwt8PHdWgmigzik1eVHezUoALS+uYWFvGoqQ7ED740M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b9b9KqJeUrZy+3voPmBfpGFlD7XJb4bgj+/EGOFui6A+1PdS7al+nW0ox9AOJ5QhsnCDtbXJVYEkNYy7dAPdbogtgKil/Oseo8A0/Mo/fgWvak4ofVncA/SJpq+NMDqPvy/s99YIUpqd42Ikrf7HQvazQIbIKMQy813Fs76lGj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U97OD5zq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U97OD5zq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B03AC32782;
	Fri, 16 Aug 2024 07:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723792237;
	bh=jwt8PHdWgmigzik1eVHezUoALS+uYWFvGoqQ7ED740M=;
	h=Date:From:To:Cc:Subject:From;
	b=U97OD5zqMoYc6tVwvc1YmxL/SI6Li8GB62moYbWxnTn69cEw+POhRES4Zm93U9FsX
	 9wiOapU9ww1r5OmfoUH5gUY7/uidY9YOK3jZrznFHWa5+GllzNFOk6D4yVmyQgI3zc
	 BeXl9BpfxVIYyjEn6gqKjinymzzK5uJvgCcFB0w0x3ejoOJN5p7L35stBZTtGoPqSU
	 4Dz4e0tS2iBQj+RTm1LWMbC/aQhDy69/6b33kw2NNmJT3GRINqqQS7Hnsr+/KSJWO5
	 mZ0z4B3qwxKr0b14MmBbkWxVkyzJccvpuxk7Gv2bKQDJnZ4aySja8WxJIkQj7cgnu3
	 KnogEqcAyKWRw==
Date: Fri, 16 Aug 2024 12:40:26 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: rcu@vger.kernel.org
Cc: paulmck@kernel.org, joel@joelfernandes.org, frederic@kernel.org,
	boqun.feng@gmail.com, urezki@gmail.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, longman@redhat.com
Subject: [PATCH rcu 0/1] RCU fixes for v6.12
Message-ID: <20240816071026.GA62718@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Below are the RCU fixes for v6.12:

1.      Use system_unbound_wq to avoid disturbing isolated CPUs, courtesy
        of Waiman Long.


Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/log/?h=fixes.12.08.24a


- Neeraj

------------------------------------------------------------------------

 kernel/rcu/tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
